/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Libraries;

import java.sql.Timestamp;

public class Patient {

    private int patientId;
    private String fullName;
    private String nic;
    private String phone;
    private String email;
    private String gender;
    private String address;
    private String medicalHistory;
    private Timestamp createdAt;

    // Constructors
    public Patient() {}

    public Patient(String fullName, String nic, String phone, String email, String gender, String address, String medicalHistory) {
        this.fullName = fullName;
        this.nic = nic;
        this.phone = phone;
        this.email = email;
        this.gender = gender;
        this.address = address;
        this.medicalHistory = medicalHistory;
    }

    // Getters and Setters
    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getMedicalHistory() { return medicalHistory; }
    public void setMedicalHistory(String medicalHistory) { this.medicalHistory = medicalHistory; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
