public class ChatterCreateTaskOperations {
// Get the custom setting records
    
    Public Static ChatterTaskCreation__c setting = null;
    
    static {
        List<ChatterTaskCreation__c> settingsList = ChatterTaskCreation__c.getAll().values();
        if (!settingsList.isEmpty()) {
            setting = settingsList[0];
        } else {
            // handle case where no settings exist
            setting = new ChatterTaskCreation__c(TaskActivityDate__c = 0); // default value
        }
    }
    
    
    //Getting Custom Activity Date Value to add in task
    Public Static Integer CustomActivityDate = (Integer)setting.TaskActivityDate__c;
    
    
    // Method to create tasks from a given body text and parent record ID
    public static List<Task> createTask(String body, Id parentId)
    {
        System.debug('Activity Date:'+CustomActivityDate);
        // Initialize lists to process the input body
        List<Task> taskToInsert = new List<Task>();
        List<string> feedBody = new List<String>();
        List<string> subjects = new List<String>();
        List<string> newFeedBody = new List<String>();
        List<String> uName = new List<String>();
        
        try
        {
            // Debug output to track input body
            System.debug('Body--->'+body);
            
            // Replace bullet points with '<li>' tags to standardize the input- Ganesh Changes
            body = body.replaceAll('•', '<li>');
            System.debug('---Body . --->'+body);
            body = body.replaceAll('\\$', '');
            System.debug('---Body $ --->'+body);
            body = body.replaceAll('\\?', '');
            System.debug('---Body ? --->'+body);
            
            // Split the body text by '</p>' to separate different segments
            feedBody = body.split('</p>');
            System.debug('feedBody--->'+feedBody);
            
            // Process each segment of the body text
            for(String str: feedBody)
            {
                // Check if the segment contains a task marker
                if(str.containsIgnoreCase('#task'))
                {
                    // Extract user names from '@' markers
                    uName.add(str.substringBetween('@', '\u200b'));
                    System.debug('uName --->'+uName);
                    
                    // Add to new feed body if segment contains '</ol>'
                    if(str.contains('</ol>')){
                        newFeedBody.add(str.substringBefore('<p>'));
                        system.debug('If newFeedBody===> '+ newFeedBody);
                    }
                }
                else
                {
                    // Add the segment to new feed body if not containing '#task'
                    newFeedBody.add(str);
                    system.debug('Else newFeedBody ===> '+ newFeedBody);
                }
            }
            
            // Convert the new feed body list to a string and split by '</li>'
            String subject = newFeedBody.toString();
            System.debug(subject);
            subjects = subject.split('</li>');
            System.debug('subjects  --->'+subjects);
            
            // Map to store user names and their corresponding User records
            Map<String, User> userId = new Map<String, User>();
            String pId = parentId;
            
            // Query User records by names extracted from feed body
            for(User us : [SELECT id, Name FROM User WHERE Name = :uName])
            {
                userId.put(us.Name, us);
            }
            
            // Process each subject to create Task records
            integer i = 0;
            for(String sub : subjects)
            {
                
                date activityDate;
                System.debug(sub);
                Task tk = new Task();
                User usr = new User();
                
                // Check if subject does not contain '</ol>'
                if(!sub.contains('</ol>'))
                {
                    System.debug(sub);
                    String finalSubject = sub.substringAfter('<li>');
                    System.debug(finalSubject);
                
                    // Process date if '#date' is present in the subject
                    if (finalSubject.containsIgnoreCase('#date')) {
                        
                        finalsubject = Finalsubject.replaceAll('(?i)#date', '#date');
                        String[] parts = finalSubject.split('#date');
                     
                        finalSubject = parts[0];
                        System.debug(finalSubject);
                        System.debug('71' + parts[1]);
                        String dateString = parts[1].trim();
                        System.debug('73' + dateString);
                        String cleanedString = dateString.replace('&nbsp;', '').trim();
                        System.debug('string date' + cleanedString);
                        
                        // Split cleaned date string into parts and parse them
                        List<String> dateParts = cleanedString.split('/');
                        System.debug('month79' + dateParts[0]);
                        dateParts[0] = dateParts[0].deleteWhitespace();
                        System.debug(dateParts[0]);
                        dateParts[0] = dateParts[0].replaceAll('\u200b', '');
                        System.debug(dateParts[0]);
                        dateParts[0] = dateParts[0].replaceAll('[^0-9]', '');
                        //dateParts[0] = dateParts[0].substring(1);
                        System.debug(dateParts[0]);
                        Integer month = Integer.valueOf(dateParts[0]);
                        System.debug(month);
                        Integer day = Integer.valueOf(dateParts[1]);
                        Integer year = Integer.valueOf(dateParts[2]);
                        activityDate = Date.newInstance(year, month, day);
                        System.debug('activityDate: ' + activityDate);
                    }
                    
                    // Set the task subject and owner
                    tk.Subject = finalSubject;
                    System.debug(finalSubject);
                    usr = userId.get(uName[i]);
                    System.debug('111' + userId.get(uName[i]));
                }
                // Process if subject contains '<li>' and '</ol>'
                else if(sub.contains('<li>') && sub.contains('</ol>'))
                {
                    System.debug(sub);
                    i++;
                    
                    String finalSubject = sub.substringAfter('<li>');
                    
                    if (finalSubject.containsIgnoreCase('#date')) {
                        
                        finalsubject = Finalsubject.replaceAll('(?i)#date', '#date');
                        String[] parts = finalSubject.split('#date');
                        
                        finalSubject = parts[0];
                        System.debug('71' + parts[1]);
                        String dateString = parts[1].trim();
                        System.debug('73' + dateString);
                        String cleanedString = dateString.replace('&nbsp;', '').trim();
                        System.debug('string date' + cleanedString);
                        
                        // Split cleaned date string into parts and parse them
                        List<String> dateParts = cleanedString.split('/');
                        System.debug('month79' + dateParts[0]);
                        dateParts[0] = dateParts[0].deleteWhitespace();
                        dateParts[0] = dateParts[0].replaceAll('\u200b', '');
                        dateParts[0] = dateParts[0].replaceAll('[^0-9]', '');
                        //dateParts[0] = dateParts[0].substring(1);
                        Integer month = Integer.valueOf(dateParts[0]);
                        Integer day = Integer.valueOf(dateParts[1]);
                        Integer year = Integer.valueOf(dateParts[2]);
                        activityDate = Date.newInstance(year, month, day);
                        System.debug('activityDate: ' + activityDate);
                    }
                    
                    
                    // Set the task subject and owner
                    tk.Subject = finalSubject;
                    System.debug('finalSubject ---'+finalSubject);
                    usr = userId.get(uName[i]);
                    System.debug('160' + userId.get(uName[i]));
                }
                else
                {
                    // Increment index and continue if subject does not match criteria
                    i++;
                    continue;
                }
                
                // Set the appropriate task parent or owner based on the parent ID
                if(pId.startsWith('003') || pId.startsWith('00Q'))
                {
                    tk.WhoId = parentId;
                }
                else if(pId.startsWith('005'))
                {
                    System.debug('userId with 005=' + usr.Id);
                    tk.OwnerId = usr.Id;
                }
                else
                {
                    tk.WhatId = parentId;
                }
                System.debug('userId=' + usr.Id);
                tk.OwnerId = usr.Id;  
                
                // Set the task activity date or default days from today
                if(activityDate != null){
                    tk.ActivityDate = activityDate;
                }
                else {
                    tk.ActivityDate = Date.today().addDays(CustomActivityDate);
                }
                
                // Add the task to the list for insertion
                taskToInsert.add(tk);
                System.debug ('taskToInsert'+taskToInsert.Size());
                System.debug ('tk'+tk);
            }
        }
        catch(Exception e)
        {
            // Output exception details for debugging
            System.debug(e.getStackTraceString());
            System.debug(e);
        }
        
        // Return the list of tasks to be inserted
        return taskToInsert;
    }
}