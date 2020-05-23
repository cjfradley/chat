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
    property name="type" ormtype="string";
    property name="created_at" ormtype="timestamp";
    
    // Relationships
    property name="messages"
		cascade="all-delete-orphan"
		fieldtype="one-to-many"
		cfc="message"
		type="array"
		fkcolumn="fk_chatId"
		inversejoincolumn="id"
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

    property name="admin"
		fieldtype="many-to-one"
		cfc="user"
		fkcolumn="fk_userId";

    


    // Constructor
    function init()
    {
        return this;
    };

    // functions
    function adminId()
    {
        if (! isStruct(this.getAdmin())) {
            return 0;
        }
        return this.getAdmin().getId();
    }

}