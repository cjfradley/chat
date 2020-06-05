/**
 * Main Authentication module
 */
component extends="coldbox.system.EventHandler" singleton {

	// DI
    property name="userService" inject="entityService:user";
    property name="ormService" inject="BaseORMService@cborm";
    property name="sessionStorage" inject="sessionStorage@cbstorages";
    property name="BCrypt" inject="BCrypt@BCrypt";
    property name="mailService" inject="mailService@cbmailservices";
    property name="validationManager" inject="ValidationManager@cbvalidation";

    this.secret = 'Aiw8c9O0EW5v+2kIAaOTQA==';

    /**
     * Show register view
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function register( event, rc, prc )
    {
        event.setView( "register" );
    }

    /**
     * Saving new user to database
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function store( event, rc, prc )
    {
        var user = userService
            .new( {
                username: rc.username,
                email: rc.email,
                password: rc.password
            } );

        var validation = validationManager.validate(user);

        if (validation.hasErrors()) {

            for (error in validation.getErrors()) {
                flash.put("error_"&error.getField(), error.getMessage());
            }

            flash.persistRC(include="username,email");
            
            relocate("auth/register");

        } else {

            user.setPassword(BCrypt.hashPassword(rc.password))
                .setVerifykey(generateKey())
                .setVerified(0);

            userService.save(user);

            // send email verification
            var sendVerifiactionEmail = sendVerificationMail(user, event);

            flash.put("info", "Eine verifizierungsmail wurde an '" & user.getEmail() & "' verschickt");
            relocate("auth/login");

        }

    }

    /**
     * Undocumented function
     *
     * @event 
     * @rc 
     * @prc 
     */
    private boolean function loginByCredentials (String email, String password)
    {

        var user = userService.findByEmail(email);

        if (isNull(user)) {
            return false;
        }

        // check password matches
        var passwordCheck = BCrypt.checkPassword( password, user.getPassword() );

        if ( ! passwordCheck ) {

            return false;

        }

        var rls = arrayNew(1);
        var prms = arrayNew(1);

        // set logged in user struct
        if (setLoggedInUser(user, rls, prms)) {
            return true;
        };
        
        return false;

    }

    /**
     * Undocumented function
     */
    private function setLoggedInUser(user, rls, prms)
    {
        sessionStorage.delete("user");

        var loggedInUser = structNew();

        loggedInUser['id'] = user.getId();
        loggedInUser['username'] = user.getUsername();
        loggedInUser['email'] = user.getEmail();
        loggedInUser['role'] = rls;
        loggedInUser['permissions'] = prms;
        
        sessionStorage.set("user", loggedInUser);

        if (sessionStorage.exists("user") && sessionStorage.get("user").id gt 0) {
            return true;
        }
        return false;
    }


    /**
     * show login view
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function login( event, rc, prc )
    {
        event.setView( "login" );
    }

    /**
     * show reset password view
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function resetpassword( event, rc, prc )
    {

        // check if key is valid
        if ( ! checkRecoveryKey(rc.recoverykey)) {
            flash.put("keyerror", "This key is not valid.");
        }

        event.setView( "resetpassword" );
    }

    /**
     * logout the currently logged in user and redirect to index page
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function logout( event, rc, prc )
    {

        sessionStorage.delete("user");

        relocate( uri="/" );

    }

    /**
     * Show permission denied page if user is not allowed to execute the action
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function permissionDenied(event, rc, prc)
    {
        prc.user = sessionStorage.get("user");

        event.setView( "401" );

    }

    /**
     * show password recovery view
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function passwordrecovery(event,rc, prc)
    {
        event.setView( "passwordrecovery" );
    }

    /**
     * set a recovery hash and an expiry date on the user for password recovery
     * send an email to given email with link to passord reset page
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function attemptsetrecoverykey(event, rc, prc)
    {
        // attempt to login with these credentials
        var user = userService.findByEmail(rc.email);

        if (! isNull(user)) {
            
            // set reecovery password
            user
                .setRecoverykey( generateKey() )
                .setRecoverykeyend( dateAdd('h', 3, now()));
            
            userService.save(user);

            var emailSent = sendRecoveryMail(user, event);

        }

        flash.put("info", "Eine Passwortreset Email wurde an die angegebene Email Adresse, geschickt sofern sie in unserer Datenbank vorhanden ist.");

        relocate("auth/passwordrecovery");

    }

    /**
     * try a login with given credentials
     * relocate to index if successfull
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function attempt( event, rc, prc )
    {
        
        // attempt to login with these credentials
        if (loginByCredentials(rc.email, rc.password)) {
            relocate( uri="/" );
        } else {
            flash.put("errors", "Verifizierung fehlgeschlagen");
            relocate( uri="/auth/login" );
        }

    }

    /**
     * reset user password
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function attemptreset(event, rc, prc)
    {

        // check if key is valid
        if ( ! checkRecoveryKey(rc.recoverykey)) {
            flash.put("keyerror", "Der Link ist nicht mehr gültig.");

            relocate("auth/resetpassword/#rc.recoverykey#" );
        } else {
            // reset user password in model
            var user = userService.findByRecoverykey(rc.recoverykey);
            user.setPassword(rc.password );
            
            var validation = validationManager.validate(target=user, fields="password");

            if (validation.hasErrors()) {
                for (error in validation.getErrors()) {
                    flash.put('error_'&error.getField(), error.getMessage());
                }

                flash.persistRC(include="password");

                relocate("auth/resetpassword/#rc.recoverykey#" );
            }

            // set and save new user password
            user.setPassword(BCrypt.hashPassword( rc.password ));
            userService.save(user);

            resetRecoveryKey(user);

            flash.put("info", "Dein Passwort wurde zurückgesetzt. Du kannst dich jetzt mit deinem neuen Passwort einloggen.");

            relocate("auth/login");

        }

    }

    any function verifyEmail(event, rc, prc)
    {

        // check if key is valid
        if ( ! checkVerifyKey(rc.key)) {
            flash.put("keyerror", "Deine Email konnte nicht verifiziert werden.");
            relocate("auth/register/#rc.recoverykey#" );
        } else {
            // reset user password in model
            var user = userService.findByVerifykey(rc.key);
            user.setVerified(1)
                .setVerifyKey('');
            userService.save(user);

            flash.put("info", "Deine Email wurde verifiziert. Du kannst dich jetzt einloggen.");

            relocate("auth/login");

        }
    }

    /**
     * reset the recovery password and expiry date
     *
     * @user 
     * @event 
     */
    private function resetRecoveryKey (user)
    {
         // reset recovery key
        user
            .setRecoverykey("")
            .setRecoverykeyend("");
        userService.save(user);
    }

    private function checkRecoveryKey (recoverykey)
    {

        // get user by recovery key
        var user = userService.findByRecoverykey( recoverykey );

        if (isNull(user)) {
            return false;
        }

        // check that recovery key date is not to old
        if (dateCompare(now(), user.getRecoverykeyend()) eq 1 ) {
            resetRecoveryKey(user);
            return false;
        }

        return true;

    }

    private function checkVerifyKey (key)
    {

        // get user by recovery key
        var user = userService.findByVerifykey( key );

        if (isNull(user)) {
            return false;
        }

        return true;

    }

    /**
     * generate a random key for password recovery
     *
     * @user 
     * @event 
     */
    private function generateKey()
    {
        var strLowerCaseAlpha = "abcdefghijklmnopqrstuvwxyz";
        var strUpperCaseAlpha = UCase( strLowerCaseAlpha );
        var strNumbers = "0123456789";

        var strAllValidChars = (strLowerCaseAlpha & strUpperCaseAlpha & strNumbers);

        var arrPassword = ArrayNew( 1 );

        arrPassword[ 1 ] = Mid(strNumbers, RandRange( 1, Len( strNumbers ) ), 1 );
        arrPassword[ 2 ] = Mid(strLowerCaseAlpha, RandRange( 1, Len( strLowerCaseAlpha ) ), 1 );
        arrPassword[ 3 ] = Mid(strUpperCaseAlpha, RandRange( 1, Len( strUpperCaseAlpha ) ), 1 );

        for (i = arrayLen(arrPassword) + 1; i <= 16; i++) {
            arrPassword[ i ] = Mid(strAllValidChars, RandRange( 1, Len( strAllValidChars ) ), 1 );
        }

        CreateObject( "java", "java.util.Collections" ).Shuffle(arrPassword);

        return ArrayToList(arrPassword, "");

    }

    /**
     * send the recovery email to user
     */
    private function sendRecoveryMail(user, event)
    {

        // send email to user
        var oMail = mailService.newMail( 
            to=user.getEmail(),
            from="cjfradley@gmail.com",
            subject="Passwort zurücksetzen",
            type="html",
            bodyTokens={
                username=user.getUsername(),
                link=event.buildLink( 'auth/resetpassword/#user.getRecoverykey()#' )
            }
        );

        var body = renderLayout(layout="email", view="emails/forgot-password");
        
        // add a Body
        oMail.setBody(body);

        // send it
        return(mailService.send( oMail ));
    }

     /**
     * send email verification email
     */
    private function sendVerificationMail(user, event)
    {

        // send email to user
        var oMail = mailService.newMail( 
            to=user.getEmail(),
            from="cjfradley@gmail.com",
            subject="Email verifizieren",
            type="html",
            bodyTokens={
                username=user.getUsername(),
                link=event.buildLink( 'auth/verify-email/#user.getVerifykey()#' )
            }
        );

        var body = renderLayout(layout="email", view="emails/verify-email");
        
        // add a Body
        oMail.setBody(body);

        // send it
        return(mailService.send( oMail ));
    }

    /**
     * add new user to all other users private chat channels
    */
    private function setupInitialUser (user)
    {
        var userIds = userService.findAllByEmailNotEqual( user.getEmail() ).map(function (item) {
            return item.getId();
        });

        for (i=1; i<=arrayLen(userIds); i=i+1) {
            var data = {
                title = '',
                body = '',
                type = 'private',
                users = [user.getId(), userIds[i]],
                created_at = now()
            };

            var chat = ormService.populate(target=ormService.new("chat"), memento=data, composeRelationships=true);
            ormService.save(chat);
        }

        WsPublish('userChannel', 'new');

    }

    private function checkAccountVerified (user)
    {
        if (user.getVerified()) {
            return true;
        }

        return false;

    }
    
}
