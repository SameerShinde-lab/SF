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

👉 **Step-by-step:**
1️⃣ Type `#task` → Press Enter → it turns blue  
2️⃣ Mention the assignee → `@UserName` → Press Enter → it turns blue  
3️⃣ On new line, type `1. ` + task subject  
4️⃣ (Optional) Add due date → `#date MM/DD/YYYY` → Press Enter → it turns blue  

🕒 If no date is mentioned, default due date is assigned per `TaskActivityDate` setting.

---

## 🚫 Limitations
❗ File upload via Chatter is not linked to task creation.  

---

## 📂 Source
This package is part of a 2GP managed package for Salesforce AppExchange.

---

## 📞 Support
For help, contact: [supports@twopirconsulting.com]
