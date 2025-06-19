@isTest
public class TestChatterCreateTaskOperations {
    @IsTest
    public static void testMD () {
        
        // Get a standard user profile
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        // Create user
        User testUser = new User(
            FirstName = 'Gopal',
            LastName = 'Maheshwari',
            Alias = 'gmah',
            Email = 'gopal.maheshwari@example.com',
            Username = 'gopal.maheshwari@example.com' + System.currentTimeMillis(),
            ProfileId = p.Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );

        insert testUser;

        
        ChatterTaskCreation__c setting = new ChatterTaskCreation__c();
        setting.Name='Test';
        setting.TaskActivityDate__c=10;
        insert setting;
        
        Contact con = new Contact();
        con.LastName = 'test123';
        insert con;
        
        FeedItem post = new FeedItem();
        post.ParentId = con.Id;
        post.Body = '<p>Test chatter</p><p>test trigger</p><p>#task​&nbsp;@Anna Blancarte​&nbsp;</p><ol><li>test08 #date​&nbsp;12/30/2024</li></ol>';
        insert post;
        
        FeedComment comment = new FeedComment();
        comment.FeedItemId = post.Id;
        comment.CommentBody ='<p>Test chatter</p><p>test trigger</p><p>#Task​&nbsp;@Anna Blancarte​&nbsp;</p><ol><li>testpost 01 #date​&nbsp;12/30/2024</li><li>testpost 02 #date​&nbsp;12/30/2024</li></ol><p>&nbsp;</p><p>#task​&nbsp;@Janelly Munoz​&nbsp;</p><ol><li>testpost 03 #date​&nbsp;12/30/2024</li></ol>';
        insert comment;
        
        FeedItem post2 = new FeedItem();
        post2.ParentId = con.Id;
        post2.Body = '<p>#task​ @Gopal Maheshwari​ </p><ol><li>test #date​ 5/22/2025</li></ol><li>test 2  #date​ 5/22/2025 </li></ol>';
        
        insert post2;
        List<Task> tk = [Select Id,Subject from Task where whoId = :con.Id];
        System.assertEquals('test', tk[0].subject);
        
    }
        
}