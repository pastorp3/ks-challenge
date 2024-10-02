## Project Setup Documentation

### Prerequisites
Before you begin, ensure you have the following installed on your system:
- **Ruby** (version 2.6 or higher)
- **Rails** (version 6 or higher)
- **PostgreSQL** (or your preferred database)
- **Bundler**
- **Node.js** and **Yarn** (for managing JavaScript dependencies)
- **Git** (for version control)

### Step 1: Clone the Repository
First, clone the repository to your local machine:
```bash
git clone <repository-url>
cd <project-directory>
```

### Step 2: Install Dependencies
Install the required gems:
```bash
bundle install
```

### Step 3: Set Up the Database
Create the database and run migrations:
```bash
rails db:create
rails db:migrate
```

### Step 4: Start the Rails Server 
You can start the server using the following command:
```bash
bin/dev
```
The application will be accessible at `http://localhost:3000`.

### Step 6: Access the Application
Open your web browser and navigate to `http://localhost:3000` to view your application.
