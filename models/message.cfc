/**
* A cool message entity
*/
component persistent="true" table="message"
{

    // Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";

	// Properties
    property name="body" ormtype="text";
    property name="created_at" ormtype="timestamp";

    // Relationships
	property name="user"
        fieldtype="one-to-one"
        cfc="user"
        fkcolumn="fk_userId";

    property name="chat"
		fieldtype="many-to-one"
		cfc="chat"
		fkcolumn="fk_chatId";


    // Constructor
    function init()
    {
		return this;
	};

}