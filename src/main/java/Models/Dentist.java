package Models;

public class Dentist {
    private int dentistId;
    private String username;
    private String password;
    private String dentistName;
    private String specialization;
    private String contactNumber;
    private String email;

    // 1. Default Constructor
    public Dentist() {}

    // 2. Full Constructor with ID (DB Retrieval)
    public Dentist(int dentistId, String username, String password, String dentistName, String specialization, String contactNumber, String email) {
        this.dentistId = dentistId;
        this.username = username;
        this.password = password;
        this.dentistName = dentistName;
        this.specialization = specialization;
        this.contactNumber = contactNumber;
        this.email = email;
    }

    // 3. Constructor Without ID (New Dentist Registration / Insert)
    public Dentist(String dentistName, String specialization, String contactNumber, String email, String username, String password) {
        this.dentistName = dentistName;
        this.specialization = specialization;
        this.contactNumber = contactNumber;
        this.email = email;
        this.username = username;
        this.password = password;
    }

    // Getters & Setters
    public int getDentistId() { return dentistId; }
    public void setDentistId(int dentistId) { this.dentistId = dentistId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getDentistName() { return dentistName; }
    public void setDentistName(String dentistName) { this.dentistName = dentistName; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}