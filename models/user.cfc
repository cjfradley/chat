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
	property name="recoverykey" ormtype="string";
	property name="recoverykeyend" ormtype="timestamp";
    property name="lastLogin" ormtype="timestamp";
  

    // Relationships
	property name="chats"
        cascade="all-delete-orphan"
        fieldtype="many-to-many"
        cfc="chat"
        type="array"
        linktable="chat_user" 
        fkcolumn="fk_userId"
        inversejoincolumn="fk_chatId"
        singularname="chat";

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
                table:"[user]", column:"email"
            },
            type="email",
            typeMessage="Scheint keine konforme Email zu sein"
        },
        "password" = {
            required=true,
            requiredMessage="Bitte ein Passwort definieren",
            min=5,
            minMessage="Das Passwort muss mindestens 5 Zeichen lang sein"
        }
    };

  // Constructor
  function init()
  {
		return this;
	};

}