import io
from flask import send_file
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter




from flask import Flask, render_template, request, redirect, url_for, session, flash
import psycopg2
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

# ================= DATABASE CONFIG =================

DB_CONFIG = {
    'dbname': 'hospiallife',
    'user': 'postgres',
    'password': '1234',
    'host': 'localhost',
    'port': '5432'
}

def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

# ================= LOGIN CHECK =================

def is_logged_in():
    return 'user_id' in session

# ================= BASIC PAGES =================



@app.route('/')
def index():
    return render_template('index.html')
       
    

# PROFILE
@app.route('/profile')
def profile():
    if not session.get('user_id'):
        return redirect(url_for('login'))

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT username, email FROM newusers WHERE id=%s", (session['user_id'],))
    user = cur.fetchone()
    conn.close()

    print("SESSION:", session)
    print("USER:", user)

    if user is None:
        return "Error: User not found. Please login again."

    return render_template('profile.html', user=user)

#book appointment
@app.route('/book_appointment', methods=['GET', 'POST'])
def book_appointment():

    if not session.get('user_id'):
        return redirect(url_for('login'))

    if request.method == 'POST':

        print("SESSION USER ID DURING INSERT:", session.get('user_id'))

        doctor_name = request.form['doctor_name']
        date = request.form['date']
        time = request.form['time']

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("""
            INSERT INTO appointments (user_id, doctor_name, date, time)
            VALUES (%s, %s, %s, %s)
        """, (session['user_id'], doctor_name, date, time))

        conn.commit()
        conn.close()

        return redirect(url_for('appointments'))

    return render_template('book_appointment.html')

# APPOINTMENTS
@app.route('/appointments', methods=['GET', 'POST'])
def appointments():

    if not session.get('user_id'):
        return redirect(url_for('login'))

    conn = get_db_connection()
    cur = conn.cursor()

    # 👉 If form submitted → Insert appointment
    if request.method == 'POST':

        doctor_name = request.form['doctor_name']
        date = request.form['date']
        time = request.form['time']

        cur.execute("""
            INSERT INTO appointments (user_id, doctor_name, date, time)
            VALUES (%s, %s, %s, %s)
        """, (session['user_id'], doctor_name, date, time))

        conn.commit()

    # 👉 Always fetch appointments after insert
    cur.execute("""
        SELECT doctor_name, date, time
        FROM appointments
        WHERE user_id = %s
    """, (session['user_id'],))

    data = cur.fetchall()

    conn.close()

    return render_template('appointments.html', data=data)

# PRESCRIPTIONS
@app.route('/prescriptions')
def prescriptions():
    if not session.get('user_id'):
        return redirect(url_for('login'))

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT medicine, dosage 
        FROM prescriptions 
        WHERE user_id=%s
    """, (session['user_id'],))

    data = cur.fetchall()
    conn.close()

    return render_template('prescriptions.html', data=data)

# REPORTS
@app.route('/reports')
def reports():
    if not session.get('user_id'):
        return redirect(url_for('login'))

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT report_name, result 
        FROM reports 
        WHERE user_id=%s
    """, (session['user_id'],))

    data = cur.fetchall()
    conn.close()

    return render_template('reports.html', data=data)
# BILLING
@app.route('/billing')
def billing():
    if not session.get('user_id'):
        return redirect(url_for('login'))

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT description, amount 
        FROM billing 
        WHERE user_id=%s
    """, (session['user_id'],))

    data = cur.fetchall()
    conn.close()

    return render_template('billing.html', data=data)

# SETTINGS
from werkzeug.security import check_password_hash, generate_password_hash

@app.route('/settings', methods=['GET', 'POST'])
def settings():
    if not session.get('user_id'):
        return redirect(url_for('login'))

    if request.method == 'POST':
        old_password = request.form['old_password']
        new_password = request.form['new_password']

        conn = get_db_connection()
        cur = conn.cursor()

        # Get current password
        cur.execute("SELECT password_hash FROM newusers WHERE id=%s", (session['user_id'],))
        user = cur.fetchone()

        if user and check_password_hash(user[0], old_password):
            new_hash = generate_password_hash(new_password)

            cur.execute("UPDATE newusers SET password_hash=%s WHERE id=%s",
                        (new_hash, session['user_id']))
            conn.commit()

            flash("Password updated successfully!", "success")
        else:
            flash("Incorrect current password", "error")

        conn.close()

    return render_template('settings.html')
@app.route('/services')
def services():
    return render_template('services.html')

@app.route('/emergency')
def emergency():
    return render_template('emergency.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

#---------------Hospitals------------------
@app.route("/hospitals", methods=["GET"])
def hospitals():

    city = request.args.get("city")

    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    if city:
        cur.execute("SELECT * FROM hospitals WHERE city ILIKE %s", ('%' + city + '%',))
    else:
        cur.execute("SELECT * FROM hospitals")

    hospitals = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("hospitals.html", hospitals=hospitals)


# =================SEARCH BLOOD DONOR =================

@app.route("/search_donor", methods=["GET"])
def search_donor():

    conn = psycopg2.connect(
        host="localhost",
        database="hospiallife",
        user="postgres",
        password="1234"
    )

    cur = conn.cursor()

    blood_type = request.args.get("blood_type")
    city = request.args.get("city")

    query = "SELECT * FROM blood_donor WHERE 1=1"
    values = []

    if blood_type and blood_type != "":
        query += " AND blood_type=%s"
        values.append(blood_type)

    if city and city != "":
        query += " AND location=%s"
        values.append(city)

    cur.execute(query, tuple(values))
    donors = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("search_donor.html", donors=donors)

# =================DASHBOARD =================

@app.route("/dashboard")
def dashboard():

    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    cur.execute("SELECT COUNT(*) FROM blood_donor")
    donors = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM blood_request")
    requests = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM organ_donor")
    organs = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM organ_request")
    request = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM hospitals")
    hospitals = cur.fetchone()[0]

    cur.close()
    conn.close()

    return render_template(
        "dashboard.html",
        donors=donors,
        requests=requests,
        organs=organs,
        request=request,
        hospitals=hospitals
    )


# ================= SEARCH ORGAN DONOR =================

@app.route("/search_organ", methods=["GET"])
def search_organ():

    conn = psycopg2.connect(
        host="localhost",
        database="hospiallife",
        user="postgres",
        password="1234"
    )
    cur=conn.cursor()

    organ_type = request.args.get("organ_type")
    location = request.args.get("location")

    query = "SELECT * FROM organ_donor WHERE 1=1"
    values = []

    if organ_type:
        query += " AND organ_type=%s"
        values.append(organ_type)

    if location:
        query += " AND location=%s"
        values.append(location)

    cur.execute(query, tuple(values))
    donors = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("search_organ.html", donors=donors)

# =================BLOG================
@app.route("/blog")
def blog():


    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    cur.execute("SELECT * FROM health_blog ORDER BY date_posted DESC")

    posts = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("blog.html", posts=posts)


# ================= SIGN UP =================

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':

        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        password_hash = generate_password_hash(password)

        conn = get_db_connection()
        cur = conn.cursor()

        try:
            cur.execute(
                "INSERT INTO newusers (username, email, password_hash) VALUES (%s,%s,%s)",
                (username, email, password_hash)
            )
            conn.commit()

            flash('Account created successfully! Please log in.', 'success')
            return redirect(url_for('login'))

        except:
            flash('Username or Email already exists!', 'error')

        finally:
            cur.close()
            conn.close()

    return render_template('signup.html')

# ================LOG IN=================

@app.route('/login', methods=['GET','POST'])
def login():

    if request.method == 'POST':

        email = request.form['email']
        password = request.form['password']

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT id, username, password_hash FROM newusers WHERE email=%s",(email,))
        user = cur.fetchone()

        cur.close()
        conn.close()

        if user and check_password_hash(user[2], password):

            session['user_id'] = user[0]
            session['username'] = user[1]

            flash('Login successful!', 'success')
            return redirect(url_for('index'))

        else:
            flash('Invalid email or password', 'error')

    return render_template('login.html')


@app.route('/logout')
def logout():
    session.clear()
    flash('Logged out successfully', 'info')
    return redirect(url_for('index'))

# ================= BLOOD DONOR =================
@app.route('/blood_donor', methods=['GET', 'POST'])
def blood_donor():

    if request.method == 'POST':

        full_name = request.form['full_name']
        address = request.form['address']
        aadhaar = request.form['aadhaar']
        hospital = request.form['hospital']
        disease = request.form['disease']
        blood_type = request.form['blood_type']
        age = request.form['age']
        location = request.form['location']
        phone = request.form['phone']
        last_donation_date = request.form['last_donation_date']

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("""
        INSERT INTO blood_donor
        (full_name, address, aadhaar_number, hospital_name, disease,
         blood_type, age, location, phone, last_donation_date)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            full_name,
            address,
            aadhaar,
            hospital,
            disease,
            blood_type,
            age,
            location,
            phone,
            last_donation_date
        ))

        conn.commit()
        cursor.close()
        conn.close()

        # -------- Receipt Data --------
        data = {
            "Name": full_name,
            "Blood Type": blood_type,
            "Age": age,
            "Location": location,
            "Phone": phone,
            "Last Donation Date": last_donation_date
        }
        return render_template(
    "receipt_page.html",
    service="Blood Donor Registration",
    name=full_name,
    blood_type=blood_type,
    age=age,
    location=location,
    phone=phone,
    last_donation_date=last_donation_date
)
        

    return render_template('blood_donor.html')



# ================= BLOOD REQUEST =================
@app.route('/blood_request', methods=['GET', 'POST'])
def blood_request():

    if request.method == 'POST':

        full_name = request.form['full_name']
        address = request.form['address']
        aadhaar = request.form['aadhaar']
        hospital = request.form['hospital']
        disease = request.form['disease']
        blood_type = request.form['blood_type']
        location = request.form['location']
        urgency = request.form['urgency']
        contact_info = request.form['contact_info']

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("""
        INSERT INTO blood_request
        (full_name, address, aadhaar_number, hospital_name, disease,
         blood_type, location, urgency, contact_info)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            full_name,
            address,
            aadhaar,
            hospital,
            disease,
            blood_type,
            location,
            urgency,
            contact_info
        ))

        conn.commit()
        cursor.close()
        conn.close()

        # -------- Receipt Data --------
        data = {
            "Name": full_name,
            "Blood Type": blood_type,
            "Hospital": hospital,
            "Location": location,
            "Urgency": urgency,
            "Contact": contact_info
        }

        pdf = generate_receipt(data, "Blood Request")

        return render_template(
    "receipt_page.html",
    service="Blood Request",
    name=full_name,
    blood_type=blood_type,
    location=location,
    phone=contact_info,
    hospital=hospital
)

    return render_template('blood_request.html')



# ================= ORGAN DONOR =================
@app.route('/organ_donor', methods=['GET', 'POST'])
def organ_donor():

    if request.method == 'POST':

        full_name = request.form['full_name']
        address = request.form['address']
        aadhaar = request.form['aadhaar']
        hospital = request.form['hospital']
        disease = request.form['disease']
        age = request.form['age']
        organ_type = request.form['organ_type']
        location = request.form['location']
        phone = request.form['phone']

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("""
        INSERT INTO organ_donor
        (full_name, address, aadhaar_number, hospital_name, disease,
         age, organ_type, location, phone)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            full_name,
            address,
            aadhaar,
            hospital,
            disease,
            age,
            organ_type,
            location,
            phone
        ))

        conn.commit()
        cursor.close()
        conn.close()

        # -------- Receipt Data --------
        data = {
            "Name": full_name,
            "Organ Type": organ_type,
            "Age": age,
            "Location": location,
            "Phone": phone,
            "Hospital": hospital
        }

        pdf = generate_receipt(data, "Organ Donor Registration")

        return render_template(
    "receipt_page.html",
    service="Organ Donor Registration",
    name=full_name,
    organ_type=organ_type,
    location=location,
    phone=phone,
    hospital=hospital
)

    return render_template('organ_donor.html')

# ================= ORGAN REQUEST ==============
@app.route('/organ_request', methods=['GET', 'POST'])
def organ_request():

    if request.method == 'POST':

        full_name = request.form['full_name']
        address = request.form['address']
        aadhaar = request.form['aadhaar']
        hospital = request.form['hospital']
        disease = request.form['disease']
        organ_type = request.form['organ_type']
        location = request.form['location']
        urgency = request.form['urgency']
        contact_info = request.form['contact_info']

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("""
        INSERT INTO organ_request
        (full_name, address, aadhaar_number, hospital_name, disease,
         organ_type, location, urgency, contact_info)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            full_name,
            address,
            aadhaar,
            hospital,
            disease,
            organ_type,
            location,
            urgency,
            contact_info
        ))

        conn.commit()
        cursor.close()
        conn.close()

        # -------- Receipt Data --------
        data = {
            "Name": full_name,
            "Organ Needed": organ_type,
            "Hospital": hospital,
            "Location": location,
            "Urgency": urgency,
            "Contact": contact_info
        }

        pdf = generate_receipt(data, "Organ Request")

        return render_template(
    "receipt_page.html",
    service="Organ Request",
    name=full_name,
    organ_type=organ_type,
    location=location,
    hospital=hospital,
    urgency=urgency
)

    return render_template('organ_request.html')




# ----------- DOWNLOAD RECEIPT ROUTE -----------
@app.route('/download_receipt')
def download_receipt():

    data = {
        "Name": request.args.get("name"),
        "Blood Type": request.args.get("blood_type"),
        "Age": request.args.get("age"),
        "Location": request.args.get("location"),
        "Phone": request.args.get("phone"),
        "Last Donation Date": request.args.get("last_donation_date")
    }

    pdf = generate_receipt(data, "registration receipt")

    return send_file(
        pdf,
        as_attachment=True,
        download_name="receipt.pdf",
        mimetype="application/pdf"
    )



#------------------receipt generate function-------------
def generate_receipt(data, title):

    buffer = io.BytesIO()

    p = canvas.Canvas(buffer, pagesize=letter)

    p.setFont("Helvetica-Bold", 18)
    p.drawString(200, 750, "MediPortal Receipt")

    p.setFont("Helvetica", 12)
    p.drawString(50, 720, f"Service: {title}")

    y = 690
    for key, value in data.items():
        p.drawString(50, y, f"{key}: {value}")
        y -= 20

    p.drawString(50, y-20, "Thank you for using MediPortal!")

    p.save()

    buffer.seek(0)

    return buffer



# ================= RUN SERVER =================

if __name__ == '__main__':
    app.run(debug=True)