/**
* A cool chat entity
*/
component persistent="true" table="chat"
{

    // Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";

    // Properties
    property name="title" ormtype="string";
    property name="body" ormtype="text";
    property name="created_at" ormtype="timestamp";
    
    // Relationships
	property name="messages"
        cascade="all-delete-orphan"
        fieldtype="many-to-many"
        cfc="message"
        type="array"
        linktable="chat_message" 
        fkcolumn="fk_chatId"
        inversejoincolumn="fk_messageId"
        singularname="message";

    property name="users"
        cascade="all-delete-orphan"
        fieldtype="many-to-many"
        cfc="user"
        type="array"
        linktable="chat_user" 
        fkcolumn="fk_chatId"
        inversejoincolumn="fk_userId"
        singularname="user";


    // Constructor
    function init()
    {
        return this;
    };

}