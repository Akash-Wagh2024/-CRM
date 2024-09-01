using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace goGst
{
    public static class DateTimeExtensions
    {
        public static DateTime StartOfWeek(this DateTime dt, DayOfWeek startOfWeek)
        {
            int diff = (7 + (dt.DayOfWeek - startOfWeek)) % 7;
            return dt.AddDays(-1 * diff).Date;
        }
    }

    public partial class Lead_Dashboard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        SqlCommand cmd = new SqlCommand();
        long admin_id = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Session["username"] != null)
                    {
                        string username = Session["username"].ToString();
                        long admin_id = GetAdminIdByUsername(username);

                        Session["admin_id"] = admin_id;
                        int currentYear = DateTime.Now.Year;
                        for (int year = currentYear; year >= currentYear - 10; year--)
                        {
                            YearDropDown.Items.Add(new ListItem(year.ToString(), year.ToString()));
                        }
                        YearDropDown.SelectedValue = currentYear.ToString();
                        PopulateGraph(currentYear);
                        PopulateClientGraph(currentYear);
                        BindLeadStatusChart();
                        BindTicketStatusChart();
                        Adjustgridlines();
                        YearDropDown.SelectedIndex = 1;
                       

                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }



        private void Adjustgridlines()
        {
            Chart3.ChartAreas[0].BackColor = Color.White;
            Chart4.ChartAreas[0].BackColor = Color.White;

            // Adjust grid lines
            Chart3.ChartAreas[0].AxisX.MajorGrid.LineColor = Color.FromArgb(200, 200, 200); // Set grid line color for X-axis
            Chart3.ChartAreas[0].AxisY.MajorGrid.LineColor = Color.FromArgb(200, 200, 200);
            Chart4.ChartAreas[0].AxisX.MajorGrid.LineColor = Color.FromArgb(200, 200, 200);
            Chart4.ChartAreas[0].AxisY.MajorGrid.LineColor = Color.FromArgb(200, 200, 200);

        }
        private void PopulateClientGraph(int year)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["crm_con"].ToString();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT MONTH(created_date) AS Month, COUNT(client_id) AS ClientCount " +
                                   "FROM client " +
                                   $"WHERE is_delete = 0 AND YEAR(created_date) = {year} " +
                                   "GROUP BY MONTH(created_date)";
                    Dictionary<int, int> clientCounts = new Dictionary<int, int>();

                    for (int month = 1; month <= 12; month++)
                    {
                        clientCounts[month] = 0;
                    }

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int month = reader.GetInt32(0);
                                int clientCount = reader.GetInt32(1);
                                clientCounts[month] = clientCount;
                            }
                        }
                    }

                    Chart4.Series["Series2"].Points.Clear();
                    Chart4.ChartAreas[0].AxisX.CustomLabels.Clear();
                    Chart4.ChartAreas[0].AxisY.Minimum = 0;

                    for (int month = 1; month <= 12; month++)
                    {
                        string monthName = GetMonthName(month);
                        Chart4.Series["Series2"].Points.AddXY(monthName, clientCounts[month]);
                        Chart4.ChartAreas[0].AxisX.CustomLabels.Add(month - 0.5, month + 0.5, monthName);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void PopulateGraph(int year)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["crm_con"].ToString();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT MONTH(created_date) AS Month, COUNT(lead_id) AS LeadCount " +
                                   "FROM lead " +
                                   $"WHERE is_delete = 0 AND YEAR(created_date) = {year} " +
                                   "GROUP BY MONTH(created_date)";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            Dictionary<int, int> leadCounts = new Dictionary<int, int>();

                            for (int month = 1; month <= 12; month++)
                            {
                                leadCounts[month] = 0;
                            }

                            while (reader.Read())
                            {
                                int month = reader.GetInt32(0);
                                int leadCount = reader.GetInt32(1);
                                leadCounts[month] = leadCount;
                            }

                            Chart3.Series["Series1"].Points.Clear();
                            Chart3.ChartAreas[0].AxisX.CustomLabels.Clear();

                            for (int month = 1; month <= 12; month++)
                            {
                                string monthName = GetMonthName(month);
                                int leadCount = leadCounts.ContainsKey(month) ? leadCounts[month] : 0;
                                Chart3.Series["Series1"].Points.AddXY(monthName, leadCount);
                                Chart3.ChartAreas[0].AxisX.CustomLabels.Add(month - 0.5, month + 0.5, monthName);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        
        private string GetMonthName(int month)
        {
            return new DateTime(2024, month, 1).ToString("MMMM");
        }

        protected void YearDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedYear;
            if (int.TryParse(YearDropDown.SelectedValue, out selectedYear))
            {
                PopulateGraph(selectedYear);
                PopulateClientGraph(selectedYear);
                
                BindLeadStatusChart();
                BindTicketStatusChart();
            }
        }



        private void InsertLeadData(int selectedYear)
        { 
            try
            {

                PopulateGraph(selectedYear);
               
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }



        private void BindTicketStatusChart()
        {
            try
            {
                string query = "SELECT status, COUNT(*) AS Count FROM ticket WHERE is_delete = 0 ";

                // Add filter conditions based on dropdown selection
                if (ddlFilter.SelectedValue == "week")
                {
                    // Filter by week
                    DateTime startOfWeek = DateTime.Today.StartOfWeek(DayOfWeek.Monday);
                    DateTime endOfWeek = startOfWeek.AddDays(7).AddSeconds(-1);
                    query += $"AND created_date >= '{startOfWeek:yyyy-MM-dd HH:mm:ss}' AND created_date <= '{endOfWeek:yyyy-MM-dd HH:mm:ss}' ";
                }
                else if (ddlFilter.SelectedValue == "month")
                {
                    // Filter by month
                    DateTime startOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                    DateTime endOfMonth = startOfMonth.AddMonths(1).AddSeconds(-1);
                    query += $"AND created_date >= '{startOfMonth:yyyy-MM-dd HH:mm:ss}' AND created_date <= '{endOfMonth:yyyy-MM-dd HH:mm:ss}' ";
                }
                else if (ddlFilter.SelectedValue == "today")
                {
                    // Filter by today
                    DateTime today = DateTime.Today;
                    query += $"AND created_date >= '{today:yyyy-MM-dd} 00:00:00' AND created_date <= '{today:yyyy-MM-dd} 23:59:59' ";
                }
                else if (ddlFilter.SelectedValue == "year")
                {
                    // Filter by year
                    int year = DateTime.Today.Year;
                    query += $"AND YEAR(created_date) = {year} ";
                }

                query += "GROUP BY status ORDER BY Count DESC"; // Sort by count in descending order

                using (SqlCommand command = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    int totalCount = 0;

                    while (reader.Read())
                    {
                        int count = Convert.ToInt32(reader["Count"]);
                        totalCount += count;
                    }

                    reader.Close();

                    reader = command.ExecuteReader(); // Reset reader

                    while (reader.Read())
                    {
                        string status = reader["status"].ToString();
                        int count = Convert.ToInt32(reader["Count"]);
                        DataPoint dataPoint = new DataPoint();
                        dataPoint.YValues = new double[] { count };
                        dataPoint.Label = $"{status} ({count})";
                        Chart2.Series["Series1"].Points.Add(dataPoint);
                    }

                    con.Close();
                }

                // Disable grid lines
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }


        private void BindLeadStatusChart()
        {
            try
            {
                string query = "SELECT status, COUNT(*) AS Count FROM lead ";

                // Check if filter by week
                if (ddlFilter.SelectedValue == "week")
                {
                    DateTime startOfWeek = DateTime.Today.StartOfWeek(DayOfWeek.Monday);
                    DateTime endOfWeek = startOfWeek.AddDays(7).AddSeconds(-1);
                    query += $"AND created_date >= '{startOfWeek:yyyy-MM-dd HH:mm:ss}' AND created_date <= '{endOfWeek:yyyy-MM-dd HH:mm:ss}' ";
                }
                // Check if filter by month
                else if (ddlFilter.SelectedValue == "month")
                {
                    DateTime startOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                    DateTime endOfMonth = startOfMonth.AddMonths(1).AddSeconds(-1);
                    query += $"AND created_date >= '{startOfMonth:yyyy-MM-dd HH:mm:ss}' AND created_date <= '{endOfMonth:yyyy-MM-dd HH:mm:ss}' ";
                }
                else if (ddlFilter.SelectedValue == "today")
                {
                    // Apply today filter
                    DateTime today = DateTime.Today;
                    query += $"AND created_date >= '{today:yyyy-MM-dd} 00:00:00' AND created_date <= '{today:yyyy-MM-dd} 23:59:59' ";
                }
                else if (ddlFilter.SelectedValue == "year")
                {
                    // Apply year filter
                    int year = DateTime.Today.Year;
                    query += $"AND YEAR(created_date) = {year} ";
                }


                query += "GROUP BY status ORDER BY Count DESC";

                using (SqlCommand command = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = command.ExecuteReader();
                  
                    int totalCount = 0;

                    while (reader.Read())
                    {
                        int count = Convert.ToInt32(reader["Count"]);
                        totalCount += count;
                    }

                    reader.Close();

                    reader = command.ExecuteReader(); // Reset reader

                    while (reader.Read())
                    {
                        string status = reader["status"].ToString();
                        int count = Convert.ToInt32(reader["Count"]);
                        DataPoint dataPoint = new DataPoint();
                        dataPoint.YValues = new double[] { count };
                        dataPoint.Label = $"{status} ({count})";
                        Chart1.Series["Series1"].Points.Add(dataPoint);
                    }

                    con.Close();
                }

                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
              
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindLeadStatusChart();
            BindTicketStatusChart();
            YearDropDown.SelectedIndex = 1;
            PopulateGraph(DateTime.Now.Year);
            PopulateClientGraph(DateTime.Now.Year);

        }

        private long GetAdminIdByUsername(string username)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                string query = "SELECT admin_id FROM Admin_login WHERE admin_username = @username";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@username", username);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            admin_id = reader.GetInt64(0);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return admin_id;
        }

    }
}