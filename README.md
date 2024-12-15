🚀 **S.L.H - User Management System for the Company** 🚀  
Welcome to the advanced management system of **S.L.H** – a subsidiary of Clalit 🏥.  

### The system allows:  
✅ **Smart and focused management** of employees and managers.  
✅ **Optimization of internal processes** to improve productivity and organizational efficiency.  
✅ **Enhanced collaboration** between all departments in the company.  

### 🎯 **Our Goal**  
To provide a modern and efficient platform for user management, leading to improved workflows and increased collaboration within the organization.  

### 🔑 **What does the system include?**  
👤 **Employee and Manager Management**: Easy addition, updates, and monitoring of data.  
📊 **Internal Process Management**: Organized workflows in a digital format.  
⚡ **Improved Information Flow**: Smart integration between the organization’s departments.  
💡 **S.L.H – Because advanced management starts with simplicity, speed, and innovation.** 💡  

This design is **clear, colorful, and engaging**, combining emojis for a special and interactive look. 🌟  
Feel free to copy it directly into your **README file** or any official documentation! 😊  



React + .NET Core Project Setup
🕵️ Prerequisites
Make sure you have the following tools installed before starting:

Node.js & npm – To run and manage the React application.
.NET Core SDK – To develop and run the ASP.NET Core backend.
Visual Studio or VS Code – Recommended IDEs for coding and debugging.
Technologies Used
The website is built using the latest technologies to ensure a fast, secure, and user-friendly experience:

Frontend (Client-Side)
🚀 React.js – For managing the user interface and user experience.
🎨 Bootstrap/SCSS – For modern, responsive, and clean design.
Backend (Server-Side)
⚙️ ASP.NET Core – For managing APIs, server-side logic, and performance optimization.
Database
🗄️ SQL Server – For securely storing and managing medical information and structured data.
Ready to Get Started?
Follow the steps above to configure the database, set up the project, and enjoy a smooth development experience! 🚀

# 🚀 Commands to Run the Client Side (React)

To run the React project, follow these steps in the terminal (Terminal/Command Prompt):

## 📂 Navigate to the Client Directory  
Move to the project folder where the client-side code is located:

```bash
cd ClientApp
📦 Install All Dependencies
Ensure that all Node packages are installed for the project:

bash
Copy code
npm install
🚀 Start the Local React Server
Run the React project in development mode:

bash
Copy code
npm start
The project will be available at: http://localhost:3000.

🔧 Additional Useful Commands
🛠️ Build the Project (Production Ready)
To create a production-ready build that can be deployed to a server, run:

bash
Copy code
npm run build
The output will be stored in the build folder.

✅ Run Unit Tests
To execute unit tests defined in the project:

bash
Copy code
npm test
🧹 Code Linting with ESLint
To check for code quality issues:

bash
Copy code
npm run lint
🌐 Serve the Project Statically (Serve Build)
If you have already built the project, you can serve the static build folder:

bash
Copy code
npm install -g serve
serve -s build


## Database Setup 🧙🏻‍♀️

To set up the database locally, follow these steps:

1. **Install SQL Server** and connect via SQL Server Management Studio.
2. **Create a new empty database** named `MyProjectDB`.
3. **Run the provided SQL script** located at `DB Side/DanielAmosShilaAppDB.sql.sql`:
   - Open the script in SSMS.
   - Execute it to create tables and insert data.

Your database is now ready to use!

# ⚙️ Setting Up Database Connection (Connection String)

In this project, the Connection String is configured in the `DbConfig.xml` file. To set up the connection for your local SQL Server, follow these steps:

## 🛠️ Step 1: Locate the `DbConfig.xml` File  
The file is located in the following path:  

```plaintext
Server Side/DanielAmosShilaAPP/DbConfig.xml
📝 Step 2: Edit the DbConfig.xml File
Open the file using a preferred text editor (e.g., Visual Studio Code or Notepad++).
Update the Connection String according to your SQL Server settings.

🔒 Example: Connection Using Trusted Connection
(Without requiring a username and password):

xml
Copy code
<connectionStrings>
   <add name="DefaultConnection" 
        connectionString="Server=YOUR_SERVER_NAME;Database=YOUR_DATABASE_NAME;Trusted_Connection=True;" 
        providerName="System.Data.SqlClient" />
</connectionStrings>
🔑 Example: Connection Using User ID and Password
(If SQL Server requires authentication):

xml
Copy code
<connectionStrings>
   <add name="DefaultConnection" 
        connectionString="Server=YOUR_SERVER_NAME;Database=YOUR_DATABASE_NAME;User Id=YOUR_USER;Password=YOUR_PASSWORD;" 
        providerName="System.Data.SqlClient" />
</connectionStrings>
🔄 Explanation of Values to Replace
Value	Explanation
YOUR_SERVER_NAME	The server name or SQL Server address (e.g., localhost or DESKTOP-XXXXXX).
YOUR_DATABASE_NAME	The name of your database (e.g., MyProjectDB).
YOUR_USER	Your SQL Server username (if required).
YOUR_PASSWORD	Your SQL Server password (if required).
✅ Summary
After updating the DbConfig.xml file with the correct details, the system will successfully connect to your SQL Server.

🔗 Tip:
Make sure your SQL Server is listening on the correct address and that the service is running properly.

