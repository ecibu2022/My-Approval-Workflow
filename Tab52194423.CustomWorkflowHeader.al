/// Represents a custom workflow header record. Contains fields for the header number, description, status, number series, and other related fields. The OnInsert trigger initializes the number series if needed.
table 52194423 "Custom Workflow Header"
{
    Caption = 'Custom Workflow Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Custom Workflow list";
    LookupPageId = "Custom Workflow list";
    
    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    NoSeriesMgt.TestManual(PurchSetup."Workflow Header No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Enum "Custom Approval Enum")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(6; OldField; Code[10])
        {
            Caption = 'Old Field';
            DataClassification = ToBeClassified;
        }
        // Add a new field with the correct type
        field(7; NewField; Text[50])
        {
            Caption = 'New Field';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Workflow Header No.");
            NoSeriesMgt.InitSeries(PurchSetup."Workflow Header No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

