# Post2Task

**Post2Task** is a Salesforce 2GP managed package designed for **Chatter task management use cases**.  
It allows users to automate task creation from Chatter posts and comments.

---

## 📌 Features

✅ Automatically create tasks from Chatter posts and comments  
✅ Extract task details like:
- Assignee
- Subject
- Due date (auto-calculated if not specified)

✅ Highly customizable to suit a wide variety of use cases  

---

## ⚙️ Setup Instructions

### 1️⃣  Trigger Settings
Chatter Task Creator uses the TriggerSetting custom setting to control task creation. By default, ChatterCommentTrigger and ChatterPostTriggerActive are enabled, but users can deactivate them to turn off task automation.

- Go to `TriggerSetting` custom setting
- Fields:
  - `ChatterCommentTrigger` → Set `true/false` to enable/disable comment task creation  
  - `ChatterPostTriggerActive` → Set `true/false` to enable/disable post task creation  

---

### 2️⃣ Handling Task Due Dates
- When commenting or posting on Chatter, if you do not mention #date MM/DD/YYYY, the system assigns      today’s date as the default due date
- The Chatter Task Creation custom setting includes a field TaskActivityDate (Number field).
- If you set this value to 5, then the due date for tasks (without a mentioned date) will be set to today + 5 days. 

---

## 📝 How to Create a Task via Chatter

How to Create a Task via Chatter:
1.Start with #task – Type #task(Not Case-Sensitive), press Enter, and ensure it turns blue.
2.Mention the Assignee – Type @UserName, press Enter, and confirm it turns blue.
3.Enter the Task Subject:
Press Enter to move to the next line.
Type 1. followed by a space, then enter the task subject (e.g., Create an email for new prospect like welcome email).
4.Add a Due Date (Optional):
After the task subject, type #date(Not Case-Sensitive), press Enter to turn it blue, then enter the due date in MM/DD/YYYY format.
5.If no date is mentioned, the system will assign the default due date based on the TaskActivityDate setting.
Create Multiple Tasks:
Press Enter to move to the next line and follow same steps


---

## 🚫 Limitations
❗ File upload via Chatter is not linked to task creation.  

---

## 📂 Source
This package is part of a 2GP managed package for Salesforce AppExchange.

---

## 📞 Support
For help, contact: [supports@twopirconsulting.com]
