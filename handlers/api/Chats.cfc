component extends="coldbox.system.EventHandler" {

    property name="ChatService" inject="entityService:chat";
    property name="MessageService" inject="entityService:message";
    property name="fractal" inject="Manager@cffractal";

}