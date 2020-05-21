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

  // Constructor
  function init()
  {
		return this;
	};

}