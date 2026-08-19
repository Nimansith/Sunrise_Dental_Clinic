package models;

public class Treatment {
    private int treatmentId;
    private String treatmentName;
    private String description;
    private double cost;

    // Default Constructor
    public Treatment() {}

    // Constructor with All Fields
    public Treatment(int treatmentId, String treatmentName, String description, double cost) {
        this.treatmentId = treatmentId;
        this.treatmentName = treatmentName;
        this.description = description;
        this.cost = cost;
    }

    // Constructor without ID (New treatment creation)
    public Treatment(String treatmentName, String description, double cost) {
        this.treatmentName = treatmentName;
        this.description = description;
        this.cost = cost;
    }

    // Getters and Setters
    public int getTreatmentId() { return treatmentId; }
    public void setTreatmentId(int treatmentId) { this.treatmentId = treatmentId; }

    public String getTreatmentName() { return treatmentName; }
    public void setTreatmentName(String treatmentName) { this.treatmentName = treatmentName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getCost() { return cost; }
    public void setCost(double cost) { this.cost = cost; }
}