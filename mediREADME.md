# MediPortal 🏥

MediPortal is a healthcare web application developed using Python, HTML, CSS, and PostgreSQL. The platform helps users find hospitals,
connect with blood donors, submit blood requests, book appointments, and access healthcare-related information
through a simple and user-friendly interface.

## Features

- Blood Donor Registration
- Blood Request Management
- Hospital Information
- Appointment Booking
- User Dashboard
- Medical Blog Section
- Contact Page
- Billing Information

## Technologies Used

- Python (Flask)
- HTML5
- CSS3
- PostgreSQL
- Jinja2 Templates

## Project Structure

```
medical_portal/
│
├── app.py
├── database.sql
├── templates/
├── static/
└── README.md
```

## Database

This project uses PostgreSQL as the backend database. The database schema is provided in `database.sql`.

## Installation

1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/MediPortal.git
```

2. Install dependencies

```bash
pip install -r requirements.txt
```

3. Create a PostgreSQL database

```sql
CREATE DATABASE hospiallife;
```

4. Import the database schema from `database.sql`

5. Update database credentials in `app.py`

6. Run the application

```bash
python app.py
```

## Future Enhancements

- Location-based hospital search
- Emergency blood request notifications
- Online consultation system
- Medical record management

## Author

**Harshita Apankar**

B.Sc. Computer Science Student
