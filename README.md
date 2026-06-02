## SQL_WildfireDatabase
This relational database system, `Wildfire_db`, tracks and analyzes wildfire incidents through 10 integrated tables. The system manages comprehensive data regarding wildfire severity, geographic locations, financial response agencies, and casualty impacts. By analyzing historical wildfire records, this project provides data-driven insights to optimize emergency resource allocation and preventative budgeting.

## Tools
* **Database Management System:** SQL Server (Transact-SQL / T-SQL)
* **Database Client:** Azure Data Studio / DBeaver

## Database Architecture
The schema is built from the ground up to ensure structural integrity and reduce data redundancy across 10 normalization-optimized tables.

### Key Features Implemented:
* **Data Integrity & Constraints:** Utilizes robust `FOREIGN KEY` relationships, custom `CHECK` constraints (e.g., preventing negative acre/casualty inputs, enforcing rigid severity scales), and strategic `DEFAULT` values.
* **Database Automation:** Features parameterized **Stored Procedures** to streamline programmatic data selection across complex date ranges.
* **Computed Columns:** Implements dynamic engine-level calculations utilizing `DATEDIFF` and `YEAR` functions to automatically compute wildfire duration and incident years upon data entry.

---

## Key Analytics & Insights
The analytical suite leverages advanced query mechanics—including **Common Table Expressions (CTEs)**, **Subqueries**, and **Window Functions (`DENSE_RANK`)**—to uncover high-value managerial insights:

* **Natural vs. Human Impact:** Querying property damage costs against specific wildfire causes revealed that major financial losses frequently stem from natural triggers (such as lightning) rather than human intervention. 
* **Protection Performance Metrics:** By calculating protected land mass as a percentage of total affected acres, analytics exposed critical bottlenecks in land-containment effectiveness, signaling areas where administrative aid should be prioritized.
* **Geographic Risk Analysis:** Aggregated data highlights exact Oregon counties (e.g., Union, Linn, Clatsop) experiencing the highest average burn rates, allowing for targeted public safety campaigns and regulation updates.
* **Workload & Expert Tracking:** Isolated top-performing emergency response personnel based on maximum fire deployment counts to assist in leadership assignments and monitor potential workforce burnout.

---

## 📂 Repository Structure
* `WildfireDB_creation.sql`: Full DDL script initializing the database, creating the 10 core tables, populating relational mock data, and establishing constraint logic.
* `WildfireDB_queries.sql`: Advanced DML analytical scripts, CTEs, window ranking functions, and stored
