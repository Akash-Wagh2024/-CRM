using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace goGst
{
    public partial class Admin_Ticket : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        long admin_id = 0; // Default value if no match is found
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    BindGridView();
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }
        //private void BindGridView()
        //{
        //    try
        //    { 
        //        SqlDataSource1.DataBind();

        //        GridView1.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
        //    }
        //}

        private void BindGridView()
        {
            try
            {

                int admin_id = Convert.ToInt32(Session["admin_id"]);

                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("Ticket_SupportAdmin_Grid", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ViewState["dt1"] = dt;

                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }

                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void txtsearch_TextChanged1(object sender, EventArgs e)
        {
            string keyword = txtsearch.Text.Trim();
            SearchData(keyword);

        }


        private void SearchData(string keyword)
        {
            try
            {
                con.Open();
                string query = "SELECT  * from ticket WHERE (status LIKE @keyword OR full_name LIKE @keyword) AND is_delete = 0";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
                DataSet ds = new DataSet();
                da.Fill(ds, "ticket");
                GridView1.DataSource = ds;
                GridView1.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }


        }



        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    int rowIndex = e.Row.RowIndex + 1;

                    Label lblSerialNumber = e.Row.FindControl("lblSerialNumber") as Label;

                    if (lblSerialNumber != null)
                    {

                        lblSerialNumber.Text = rowIndex.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }
        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlFilter.SelectedValue;
            BindData(selectedValue);
        }

        private void BindData(string selectedValue)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                try
                {
                    string query = "SELECT * FROM [ticket] WHERE is_delete = 0";

                    // Append filter condition based on the selected value
                    switch (selectedValue)
                    {
                        case "today":
                            query += " AND created_date >= @StartDate AND created_date < @EndDate";
                            break;
                        case "week":
                            query += " AND created_date >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0) AND created_date < DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) + 1, 0)";
                            break;
                        case "month":
                            query += " AND created_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) AND created_date < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0)";
                            break;
                        case "year":
                            query += " AND created_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) AND created_date < DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()) + 1, 0)";
                            break;
                        default:
                            break;
                    }

                    SqlCommand cmd = new SqlCommand(query, conn);

                    // Set parameters for date range if necessary
                    if (selectedValue == "today")
                    {
                        cmd.Parameters.AddWithValue("@StartDate", DateTime.Today);
                        cmd.Parameters.AddWithValue("@EndDate", DateTime.Today.AddDays(1));
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    conn.Open();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
                }
            }
        }

    }
}