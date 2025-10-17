@isTest
public class TestChatterCreateTaskOperations {
   @IsTest
    public static void testMD () {
        // 1. Get the System Administrator profile
        Profile sysAdminProfile = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'System Administrator' 
            LIMIT 1
        ];
        
        // 2. Create the User
        User adminUser2 = new User(
            FirstName = 'Test2',
            LastName  = 'Admin',
            Alias     = 'tadmin',
            Email     = 'testadmin' + System.currentTimeMillis() + '@example.com',
            Username  = 'testadmin' + System.currentTimeMillis() + '@example.com',
            ProfileId = sysAdminProfile.Id,
            TimeZoneSidKey      = 'Asia/Kolkata',   // adjust to your timezone
            LocaleSidKey        = 'en_US',
            EmailEncodingKey    = 'UTF-8',
            LanguageLocaleKey   = 'en_US'
        );
        
        insert adminUser2;
        
        // Get a standard user profile
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        // Create user
        User standardUser2 = new User(
            FirstName = 'Test2',
            LastName = 'Standard',
            Alias = 'tstand',
            Email = 'tstandard@example.com',
            Username = 'tstandard@example.com' + System.currentTimeMillis(),
            ProfileId = p.Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );

        insert standardUser2;

        
        System.runAs(standardUser2) {ChatterTaskCreation__c setting = new ChatterTaskCreation__c();
        setting.Name='Test';
        setting.TaskActivityDate__c=10;
        insert setting;
        
        Contact con = new Contact();
        con.LastName = 'test123';
        insert con;
        
        FeedItem post = new FeedItem();
        post.ParentId = con.Id;
        post.Body = '<p>Test chatter</p><p>test trigger</p><p>#task​&nbsp;@Test2 Admin​&nbsp;</p><ol><li>test08 #date​&nbsp;12/30/2024</li></ol>';
        insert post;
        
        FeedComment comment = new FeedComment();
        comment.FeedItemId = post.Id;
        comment.CommentBody ='<p>Test chatter</p><p>test trigger</p><p>#Task​&nbsp;@Test2 Admin​&nbsp;</p><ol><li>testpost 01 #date​&nbsp;12/30/2024</li><li>testpost 02 #date​&nbsp;12/30/2024</li></ol><p>&nbsp;</p><p>#task​&nbsp;@Test2 Admin​&nbsp;</p><ol><li>testpost 03 #date​&nbsp;12/30/2024</li></ol>';
        insert comment;
        
        FeedItem post2 = new FeedItem();
        post2.ParentId = con.Id;
        post2.Body = '<p>#task​ @Test2 Standard​ </p><ol><li>test #date​ 5/22/2025</li></ol><li>test 2  #date​ 5/22/2025 </li></ol>';
        
        insert post2;
        
        FeedComment comment2 = new FeedComment();
        comment2.FeedItemId = post2.Id;
        comment2.CommentBody ='<p>#task​ @Test2 Standard​ </p><ol><li>test #date​ 5/22/2025</li></ol><li>test 2  #date​ 5/22/2025 </li></ol>';
        insert comment2;

        List<Task> tk = [Select Id,Subject from Task where whoId = :con.Id AND Subject = 'test' LIMIT 1];
        System.assertEquals('test', tk[0].subject, 'Task subject should match "test"');
        
    }
    }
       @IsTest
    public static void testMD2 () {
       Profile sysAdminProfile = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'System Administrator' 
            LIMIT 1
        ];
        
        // 2. Create the User
        User adminUser = new User(
            FirstName = 'Test',
            LastName  = 'Admin',
            Alias     = 'tadmin',
            Email     = 'testadmin' + System.currentTimeMillis() + '@example.com',
            Username  = 'testadmin' + System.currentTimeMillis() + '@example.com',
            ProfileId = sysAdminProfile.Id,
            TimeZoneSidKey      = 'Asia/Kolkata',   // adjust to your timezone
            LocaleSidKey        = 'en_US',
            EmailEncodingKey    = 'UTF-8',
            LanguageLocaleKey   = 'en_US'
        );
        
        insert adminUser;
        Contact conTest2 = new Contact();
        conTest2.LastName = 'test12345';
        insert conTest2;
        
        FeedItem post01 = new FeedItem();
        post01.ParentId = conTest2.Id;
        post01.Body = '<p>#task​ @Test Admin​ </p><ol><li>test #date​ 5/22/2025</li></ol><li>test 2  #date​ 5/22/2025 </li></ol>';
        insert post01;
        
        FeedComment comment01 = new FeedComment();
        comment01.FeedItemId = post01.Id;
        comment01.CommentBody ='<p>Test chatter01</p><p>test trigger01</p><p>#Task​&nbsp;@Test Admin​&nbsp;</p><ol><li>testpost 01 #date​&nbsp;12/30/2024</li><li>testpost 02 #date​&nbsp;12/30/2024</li></ol><p>&nbsp;</p><p>#task​&nbsp;@Janelly Munoz​&nbsp;</p><ol><li>testpost 03 #date​&nbsp;12/30/2024</li></ol>';
        insert comment01;
        
             

        List<Task> tk2 = [Select Id,Subject from Task where whoId = :conTest2.Id AND Subject = 'test' LIMIT 1 ];
        System.debug('Tasks created in testMD2: ' + tk2);
        System.assertEquals('test', tk2[0].Subject, 'Task subject should match "test" in testMD2');
        }
    
    @IsTest
    public static void testMD3 () {
        // 1. Get the System Administrator profile
        Profile sysAdminProfile = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'System Administrator' 
            LIMIT 1
        ];
        
        // 2. Create the User
        User adminUser3 = new User(
            FirstName = 'Test',
            LastName  = 'Admin3',
            Alias     = 'tadmin',
            Email     = 'testadmin' + System.currentTimeMillis() + '@example.com',
            Username  = 'testadmin' + System.currentTimeMillis() + '@example.com',
            ProfileId = sysAdminProfile.Id,
            TimeZoneSidKey      = 'Asia/Kolkata',   // adjust to your timezone
            LocaleSidKey        = 'en_US',
            EmailEncodingKey    = 'UTF-8',
            LanguageLocaleKey   = 'en_US'
        );
        
        insert adminUser3;
        System.runAs(adminUser3) {
        Contact conTest2 = new Contact();
        conTest2.LastName = 'test12345';
        insert conTest2;
        
        FeedItem post01 = new FeedItem();
        post01.ParentId = conTest2.Id;
        post01.Body = '<p>#task​ @Test Admin3​ </p><ol><li>test #date​ 5/22/2025</li></ol><li>test 2  #date​ 5/22/2025 </li></ol>';
        insert post01;
        
        FeedComment comment01 = new FeedComment();
        comment01.FeedItemId = post01.Id;
        comment01.CommentBody ='<p>Test chatter01</p><p>test trigger01</p><p>#Task​&nbsp;@Test Admin3​&nbsp;</p><ol><li>testpost 01 #date​&nbsp;12/30/2024</li><li>testpost 02 #date​&nbsp;12/30/2024</li></ol><p>&nbsp;</p><p>#task​&nbsp;@Janelly Munoz​&nbsp;</p><ol><li>testpost 03 #date​&nbsp;12/30/2024</li></ol>';
        insert comment01;
        
             

        List<Task> tk2 = [Select Id,Subject from Task where whoId = :conTest2.Id AND Subject = 'test' LIMIT 1 ];
        System.debug('Tasks created in testMD2: ' + tk2);
        System.assertEquals('test', tk2[0].Subject, 'Task subject should match "test" in testMD3');
        }}
    
    
}