trigger ChatterPostTrigger on FeedItem (after insert) {
//Trigger Deactivation
   TriggerSetting__c setting = TriggerSetting__c.getOrgDefaults();
    if(setting.ChatterPostTriggerActive__c) {
        return;
    }
    
    
    
    List<Task> taskToInsert = new List<Task>();
    for(FeedItem fItem:trigger.new)
    {
        //If body contains #task then it will send body and parent Id to ChatterCreateTaskOperations to handle further exceution
        if(fItem.Body.containsIgnoreCase('#task')){
            taskToInsert.addAll(ChatterCreateTaskOperations.createTask(fItem.Body, fItem.ParentId));
        }
    }
    try{
        if(taskToInsert != null || !taskToInsert.isEmpty()){
            insert taskToInsert;
        }
    }catch(DmlException exp){
        System.debug(exp);
    }
}