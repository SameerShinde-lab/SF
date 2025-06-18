trigger ChatterCommentTrigger on FeedComment (after insert) {
//Trigger Deactivation
    TriggerSetting__c setting = TriggerSetting__c.getOrgDefaults();
    if(setting.ChatterCommentTrigger__c) {
        return;
    }
    
    
    List<Task> taskToInsert = new List<Task>();
    for(FeedComment chatterComment:trigger.new)
    {
        //If body contains #task then it will send body and parent Id to ChatterCreateTaskOperations to handle further exceution
        if(chatterComment.CommentBody.containsIgnoreCase('#task')){
            
            taskToInsert.addAll(ChatterCreateTaskOperations.createTask(chatterComment.CommentBody, chatterComment.ParentId));
        }
    }
    try{
        if(taskToInsert != null || !taskToInsert.isEmpty()){
            insert taskToInsert;
        }
    }catch(DmlException exp){
        System.debug(exp.getStackTraceString());
    }
}