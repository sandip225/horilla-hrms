# Horilla HRM - Complete User Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Admin Guide](#admin-guide)
4. [Employee/User Guide](#employeeuser-guide)
5. [Module Details](#module-details)

---

## Introduction

Horilla is a Free and Open Source HRMS (Human Resource Management System) designed to streamline HR processes. This guide covers all modules from both Admin and Employee perspectives.

### Key Modules
- Employee Management
- Recruitment
- Onboarding
- Attendance
- Leave Management
- Payroll
- Performance Management (PMS)
- Asset Management
- Helpdesk
- Offboarding

---

## Getting Started

### First Login
1. Navigate to `http://localhost:8000`
2. Login with your superuser credentials
3. You'll see the main dashboard

### User Roles
| Role | Description |
|------|-------------|
| **Super Admin** | Full system access, can manage all settings |
| **HR Manager** | Manage employees, recruitment, leaves, payroll |
| **Department Manager** | Manage team members, approve leaves/attendance |
| **Employee** | Self-service portal access |

---

## Admin Guide

### 1. Initial Setup (First Time)

#### Company Setup
1. Go to **Settings** → **Company**
2. Click **Add Company**
3. Fill in:
   - Company Name
   - Logo
   - Address
   - Contact Details
   - Date Format
   - Time Zone
4. Mark as **HQ** if it's the headquarters

#### Department Setup
1. Go to **Settings** → **Department**
2. Click **Add Department**
3. Enter Department Name
4. Assign to Company

#### Job Positions & Roles
1. Go to **Settings** → **Job Position**
2. Create positions (e.g., Software Engineer, HR Manager)
3. Go to **Settings** → **Job Role**
4. Create roles under each position

#### Shifts Setup
1. Go to **Settings** → **Shift**
2. Create shifts with:
   - Shift Name (e.g., Morning, Night)
   - Start Time & End Time
   - Grace Time for late arrivals
   - Minimum working hours

#### Work Types
1. Go to **Settings** → **Work Type**
2. Create types: Full-time, Part-time, Remote, Hybrid

---

### 2. Employee Management (Admin)

#### Adding New Employee
1. Go to **Employee** → **Employee**
2. Click **Add Employee**
3. Fill **Personal Information**:
   - First Name, Last Name
   - Email (used for login)
   - Phone (used as initial password)
   - Gender, DOB, Address
   - Profile Photo

4. Fill **Work Information**:
   - Department
   - Job Position & Role
   - Reporting Manager
   - Shift
   - Work Type
   - Employee Type (Permanent/Contract)
   - Joining Date
   - Basic Salary

5. Fill **Bank Details**:
   - Bank Name
   - Account Number
   - Branch, IFSC Code

6. Click **Save**

> **Note**: System auto-creates a user account with email as username and phone as password.

#### Employee Actions
| Action | How To |
|--------|--------|
| View Profile | Click on employee name |
| Edit | Click Edit icon |
| Archive | Actions → Archive |
| Export | Select employees → Export |
| Send Email | Select → Send Mail |

#### Bulk Operations
- **Bulk Import**: Employee → Import → Upload CSV
- **Bulk Update**: Select multiple → Bulk Update
- **Bulk Archive**: Select multiple → Archive

---

### 3. Recruitment Module (Admin)

#### Creating Recruitment
1. Go to **Recruitment** → **Recruitment**
2. Click **Create**
3. Fill:
   - Title
   - Job Position(s)
   - Vacancy Count
   - Start/End Date
   - Description
   - Assign Recruitment Managers
4. Check **Is Published** to show on career page

#### Managing Stages
Default stages are created automatically:
1. **Initial** - New applications
2. **Applied** - Screened candidates
3. **Test** - Assessment stage
4. **Interview** - Interview rounds
5. **Hired** - Selected candidates
6. **Cancelled** - Rejected candidates

To customize:
1. Go to Recruitment → Stages
2. Add/Edit stages
3. Assign Stage Managers
4. Set sequence order

#### Candidate Management
1. **Add Candidate**: Recruitment → Candidates → Add
2. **Move Stage**: Drag-drop in pipeline view OR Edit → Change Stage
3. **Schedule Interview**: Candidate → Schedule Interview
4. **Add Notes**: Candidate → Notes → Add Note
5. **Send Offer**: Candidate → Send Offer Letter

#### Pipeline View
- Visual Kanban board showing candidates in each stage
- Drag and drop to move candidates
- Filter by recruitment, stage, date

#### Skill Zone (Talent Pool)
Store promising candidates for future:
1. Go to Recruitment → Skill Zone
2. Create zones (e.g., "Python Developers", "Sales Talent")
3. Add candidates from any recruitment

---

### 4. Onboarding Module (Admin)

#### Creating Onboarding
1. Go to **Onboarding** → **Onboarding**
2. Click **Create**
3. Select hired candidate
4. Set stages and tasks

#### Onboarding Stages
Create stages like:
- Document Collection
- IT Setup
- Training
- Department Introduction

#### Onboarding Tasks
For each stage, create tasks:
- Task Title
- Assigned To (HR/Manager/IT)
- Due Date
- Description

#### Tracking Progress
- Dashboard shows onboarding status
- Mark tasks complete as they finish
- Convert to employee when complete

---

### 5. Attendance Module (Admin)

#### Attendance Settings
1. Go to **Settings** → **Attendance Settings**
2. Configure:
   - Validation conditions
   - Overtime rules
   - Auto-approve settings
   - Grace time

#### Attendance Validation Conditions
```
Worked Hours Auto Approve Till: 08:00
Minimum Overtime to Approve: 01:00
Overtime Cutoff: 04:00
Auto Approve OT: Yes/No
```

#### Managing Attendance
1. **View All**: Attendance → Attendance
2. **Validate**: Select → Validate (approves worked hours)
3. **Approve Overtime**: Select → Approve OT
4. **Bulk Attendance**: Attendance → Batch Attendance

#### Late Come / Early Out
- System auto-tracks based on shift timings
- View in Attendance → Late Come Early Out
- Apply penalties if configured

#### Hour Account
Monthly summary showing:
- Total Worked Hours
- Pending Hours
- Overtime Hours
- Per employee breakdown

---

### 6. Leave Module (Admin)

#### Leave Type Setup
1. Go to **Leave** → **Leave Type**
2. Click **Create**
3. Configure:

| Field | Description |
|-------|-------------|
| Name | e.g., Casual Leave, Sick Leave |
| Payment | Paid / Unpaid |
| Total Days | Annual allocation |
| Reset | Enable for yearly reset |
| Reset Based | Yearly/Monthly/Weekly |
| Reset Month/Day | When to reset |
| Carryforward | No/Yes/With Expiry |
| Carryforward Max | Maximum days to carry |
| Require Approval | Yes/No |
| Require Attachment | Yes/No |
| Exclude Holidays | Yes/No |
| Exclude Company Leave | Yes/No |

#### Assigning Leaves
1. Go to **Leave** → **Assign Leave**
2. Select employees
3. Select leave type
4. Set available days
5. Click Assign

#### Leave Requests (Admin View)
1. Go to **Leave** → **Leave Request**
2. View all requests
3. Actions:
   - **Approve**: Approve selected
   - **Reject**: Reject with reason
   - **Cancel**: Cancel approved leave

#### Holidays Setup
1. Go to **Leave** → **Holiday**
2. Add holidays:
   - Name
   - Start Date
   - End Date
   - Recurring (yearly)

#### Company Leaves (Weekly Off)
1. Go to **Leave** → **Company Leave**
2. Set weekly offs:
   - Based on Week (1st, 2nd, etc. or All)
   - Based on Day (Saturday, Sunday)

---

### 7. Payroll Module (Admin)

#### Payroll Setup

##### Allowances
1. Go to **Payroll** → **Allowance**
2. Create allowances:
   - HRA (House Rent Allowance)
   - DA (Dearness Allowance)
   - Travel Allowance
   - Medical Allowance

##### Deductions
1. Go to **Payroll** → **Deduction**
2. Create deductions:
   - PF (Provident Fund)
   - Tax
   - Insurance
   - Loan EMI

##### Pay Schedules
1. Go to **Payroll** → **Pay Schedule**
2. Create schedule:
   - Monthly / Weekly / Bi-weekly
   - Pay day

#### Contract Setup
1. Go to **Payroll** → **Contract**
2. Create employee contract:
   - Employee
   - Basic Salary
   - Allowances (select applicable)
   - Deductions (select applicable)
   - Contract Period

#### Generating Payslips
1. Go to **Payroll** → **Payslip**
2. Click **Generate Payslip**
3. Select:
   - Pay Period (Month/Year)
   - Employees
4. Review calculations
5. Click Generate

#### Payslip Actions
- **View**: See detailed breakdown
- **Send**: Email payslip to employee
- **Download**: PDF download
- **Bulk Send**: Send to multiple employees

---

### 8. Performance Management (Admin)

#### Setting Up PMS

##### Key Result Areas (KRA)
1. Go to **PMS** → **KRA**
2. Create KRAs for each job position

##### Objectives
1. Go to **PMS** → **Objective**
2. Create objectives:
   - Title
   - Description
   - Assigned To
   - Start/End Date
   - Key Results

##### Feedback
1. Go to **PMS** → **Feedback**
2. Create feedback cycles
3. Assign reviewers

##### 360° Review
- Self Assessment
- Manager Review
- Peer Review
- Subordinate Review

---

### 9. Asset Management (Admin)

#### Asset Categories
1. Go to **Asset** → **Asset Category**
2. Create categories:
   - Laptop
   - Mobile
   - ID Card
   - Furniture

#### Adding Assets
1. Go to **Asset** → **Asset**
2. Click **Add Asset**
3. Fill:
   - Asset Name
   - Category
   - Serial Number
   - Purchase Date
   - Value
   - Status (Available/Assigned/Maintenance)

#### Asset Assignment
1. Select Asset
2. Click **Assign**
3. Select Employee
4. Set assignment date
5. Add notes if any

#### Asset Requests
- Employees can request assets
- Admin approves/rejects
- Track all assignments

---

### 10. Helpdesk Module (Admin)

#### Ticket Categories
1. Go to **Helpdesk** → **Category**
2. Create categories:
   - IT Support
   - HR Query
   - Facilities
   - Payroll Issue

#### Managing Tickets
1. View all tickets in **Helpdesk** → **Tickets**
2. Assign to team members
3. Update status:
   - Open
   - In Progress
   - Resolved
   - Closed
4. Add comments/responses

---

### 11. Offboarding Module (Admin)

#### Offboarding Setup
1. Go to **Offboarding** → **Offboarding**
2. Create offboarding stages:
   - Exit Interview
   - Asset Return
   - Knowledge Transfer
   - Final Settlement
   - Account Deactivation

#### Processing Offboarding
1. Select employee to offboard
2. Create offboarding record
3. Assign tasks to respective teams
4. Track completion
5. Generate relieving letter
6. Archive employee

---

## Employee/User Guide

### 1. First Login

1. Open `http://localhost:8000`
2. Enter credentials:
   - Username: Your email
   - Password: Your phone number (initial)
3. Change password on first login

### 2. Dashboard

Your dashboard shows:
- Today's attendance status
- Leave balance
- Pending requests
- Announcements
- Upcoming holidays

### 3. Profile Management

#### View Profile
1. Click your name (top right)
2. Select **My Profile**

#### Update Profile
1. Go to Profile
2. Click **Edit**
3. Update allowed fields:
   - Phone
   - Address
   - Emergency Contact
   - Profile Photo
4. Click **Save**

> **Note**: Some fields like Department, Position require HR approval.

---

### 4. Attendance (Employee)

#### Check-In
1. Go to **Attendance** → **Check-In**
2. Click **Check In** button
3. System records your check-in time

#### Check-Out
1. Go to **Attendance** → **Check-Out**
2. Click **Check Out** button
3. System calculates worked hours

#### View My Attendance
1. Go to **Attendance** → **My Attendance**
2. See daily/monthly attendance
3. View:
   - Check-in/out times
   - Worked hours
   - Overtime
   - Late arrivals

#### Request Attendance Correction
1. Go to **Attendance** → **Attendance Request**
2. Click **Create Request**
3. Fill:
   - Date
   - Correct Check-in/out time
   - Reason
4. Submit for approval

---

### 5. Leave Management (Employee)

#### Check Leave Balance
1. Go to **Leave** → **My Leave**
2. View available leaves by type

#### Apply for Leave
1. Go to **Leave** → **Leave Request**
2. Click **Create**
3. Fill:
   - Leave Type
   - Start Date
   - End Date
   - Start Date Breakdown (Full/First Half/Second Half)
   - End Date Breakdown
   - Reason
   - Attachment (if required)
4. Click **Submit**

#### Track Leave Status
- **Requested**: Pending approval
- **Approved**: Leave granted
- **Rejected**: Not approved (check reason)
- **Cancelled**: You cancelled the request

#### Cancel Leave
1. Go to your leave request
2. Click **Cancel** (only before start date)

---

### 6. Payroll (Employee)

#### View Payslips
1. Go to **Payroll** → **My Payslip**
2. Select month/year
3. View detailed breakdown:
   - Basic Salary
   - Allowances
   - Deductions
   - Net Pay

#### Download Payslip
1. Open payslip
2. Click **Download PDF**

---

### 7. Asset Management (Employee)

#### View My Assets
1. Go to **Asset** → **My Assets**
2. See all assigned assets

#### Request Asset
1. Go to **Asset** → **Asset Request**
2. Click **Create Request**
3. Select asset category
4. Add reason
5. Submit

#### Return Asset
1. Go to your assigned asset
2. Click **Return Request**
3. Add condition notes
4. Submit for processing

---

### 8. Helpdesk (Employee)

#### Raise Ticket
1. Go to **Helpdesk** → **Create Ticket**
2. Fill:
   - Category
   - Subject
   - Description
   - Priority
   - Attachments
3. Submit

#### Track Tickets
1. Go to **Helpdesk** → **My Tickets**
2. View status and responses
3. Add comments if needed

---

### 9. Performance (Employee)

#### View Objectives
1. Go to **PMS** → **My Objectives**
2. See assigned objectives and key results

#### Self Assessment
1. Go to **PMS** → **Self Assessment**
2. Rate your performance
3. Add comments
4. Submit

#### View Feedback
1. Go to **PMS** → **My Feedback**
2. See feedback from managers/peers

---

## Module Details

### Data Flow Summary

```
Recruitment → Onboarding → Employee → Daily Operations → Offboarding
                                           ↓
                              ┌────────────┼────────────┐
                              ↓            ↓            ↓
                         Attendance     Leave       Payroll
                              ↓            ↓            ↓
                         Validation   Approval    Payslip
```

### Permission Matrix

| Module | Admin | Manager | Employee |
|--------|-------|---------|----------|
| Employee - View All | ✅ | Team Only | Self Only |
| Employee - Create | ✅ | ❌ | ❌ |
| Attendance - Validate | ✅ | Team Only | ❌ |
| Leave - Approve | ✅ | Team Only | ❌ |
| Payroll - Generate | ✅ | ❌ | ❌ |
| Recruitment | ✅ | If Manager | ❌ |
| Asset - Assign | ✅ | ❌ | ❌ |

---

## Tips & Best Practices

### For Admins
1. **Regular Backups**: Use Horilla Backup module
2. **Audit Logs**: Check horilla_audit for tracking changes
3. **Automations**: Set up horilla_automations for repetitive tasks
4. **Reports**: Use Report module for analytics

### For Employees
1. **Daily Check-in**: Don't forget to mark attendance
2. **Plan Leaves**: Apply in advance for better approval chances
3. **Update Profile**: Keep emergency contacts updated
4. **Check Payslips**: Verify deductions monthly

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl + /` | Open search |
| `Esc` | Close modal |

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Can't login | Check email/password, contact HR |
| Attendance not saving | Check internet, try refresh |
| Leave balance wrong | Contact HR for correction |
| Payslip not visible | Wait for HR to generate |

---

## Support

For technical issues:
1. Raise Helpdesk ticket
2. Contact HR department
3. Check Horilla documentation: https://www.horilla.com/docs

---

*This guide covers Horilla HRM v1.x. Features may vary in different versions.*
