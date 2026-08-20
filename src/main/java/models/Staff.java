package models;

public class Staff {
    private int staffId;
    private String username;
    private String password;
    private String staffName;
    private String role;
    private String email;
    private String contactNumber;

    // Default Constructor
    public Staff() {}

    // Constructor with All Fields
    public Staff(int staffId, String username, String password, String staffName, String role, String email, String contactNumber) {
        this.staffId = staffId;
        this.username = username;
        this.password = password;
        this.staffName = staffName;
        this.role = role;
        this.email = email;
        this.contactNumber = contactNumber;
    }

    // Constructor for New Registration
    public Staff(String username, String password, String staffName, String role, String email, String contactNumber) {
        this.username = username;
        this.password = password;
        this.staffName = staffName;
        this.role = role;
        this.email = email;
        this.contactNumber = contactNumber;
    }

    // Getters & Setters
    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getStaffName() { return staffName; }
    public void setStaffName(String staffName) { this.staffName = staffName; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public Object getPatientName() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}