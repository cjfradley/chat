/**
* A cool user entity
*/
component persistent="true" table="user"
{
  // Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";

	// Properties
	property name="username" ormtype="string";
	property name="email" ormtype="string";
    property name="password" ormtype="string";
    property name="verified" ormtype="boolean" sqltype="bit";
    property name="verifykey" ormtype="string";
	property name="recoverykey" ormtype="string";
	property name="recoverykeyend" ormtype="timestamp";
    property name="lastLogin" ormtype="timestamp";
  

    // Relationships
	property name="chats"
        fieldtype="many-to-many"
        cfc="chat"
        type="array"
        linktable="chat_user" 
        fkcolumn="fk_userId"
        inversejoincolumn="fk_chatId"
        singularname="chat";


    this.system = createObject( "java", "java.lang.System" );
    this.environment = this.system.getenv();

    // Validation
    this.constraints = {
        "username" = {
            required=true,
            requiredMessage: "Bitte Ihren Namen angeben"
        },
        "email" =  {
            required=true,
            requiredMessage="Bitte Ihre Email angeben",
            unique={
                table: this.environment.DB_USER_CONTRAINTS ?: '[user]', column:"email"
            },
            uniqueMessage="Diese email ist bereits registriert",
            type="email",
            typeMessage="Scheint keine konforme Email zu sein",
            method="checkRegisterEmailAllowed",
            methodMessage="Diese Email darf nicht registriert werden"
        },
        "password" = {
            required=true,
            requiredMessage="Bitte ein Passwort definieren",
            regex="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$",
            regexMessage="Das Passwort muss mindestens 5 Zeichen lang sein und muss mindestens einen Buchstaben und eine Zahl beinhalten"
        }
    };

  // Constructor
  function init()
  {
		return this;
    };
    

    
    /**
     * checkRegisterEmailAllowed
     */
    any function checkRegisterEmailAllowed(value, target)
    {

        var allowedDomains = 'nextron.ch';

        if (listFind(allowedDomains, listGetAt(value, 2, '@'))) {
            return true;
        }

        return false;
    }
    

}