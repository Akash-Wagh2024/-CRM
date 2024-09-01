using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class enquiry : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        long admin_id = 0; // Default value if no match is found
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["username"] != null)
                {
                    string username = Session["username"].ToString();
                    admin_id = GetAdminIdByUsername(username); // Update the class-level variable

                    Session["admin_id"] = admin_id;
                    BindFeedbackData();
                    RegisterPostBackControls();
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }

        }
        private long GetAdminIdByUsername(string username)
        {
            long admin_id = 0;

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

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            return admin_id;
        }
        public void BindFeedbackData()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM [enquiry] Where is_delete=0", conn);
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
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hfenquiry_id = (HiddenField)e.Row.FindControl("hfenquiry_id");
                hfenquiry_id.Value = DataBinder.Eval(e.Row.DataItem, "enquiry_id").ToString();

                HiddenField hfproduct_id = (HiddenField)e.Row.FindControl("hfproduct_id");
                hfproduct_id.Value = DataBinder.Eval(e.Row.DataItem, "product_id").ToString();
            }
        }

        protected void btnNextTable_Click(object sender, EventArgs e)
        {
            // Implement logic for the button click here
        }

        protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int statusColumnIndex = 9;

                if (e.Row.Cells.Count > statusColumnIndex && e.Row.Cells[statusColumnIndex].Text == "Convert to Customer")
                {
                    HyperLink link = new HyperLink();
                    link.Text = "Convert to Customer";
                    link.NavigateUrl = "Addnewclient.aspx?enquiry_id=" + ((HiddenField)e.Row.FindControl("hfenquiry_id")).Value;

                    e.Row.Cells[statusColumnIndex].Controls.Add(link);
                }
            }
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


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow selectedRow = GridView1.SelectedRow;

            if (selectedRow != null && selectedRow.RowIndex >= 0 && selectedRow.RowIndex < GridView1.DataKeys.Count)
            {
                string status = GridView1.DataKeys[selectedRow.RowIndex]["status"].ToString();

                if (status == "Convert to Customer")
                {
                    Response.Redirect("Addnewclient.aspx?status=Convert%20to%20Customer");
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            // Implement logic for the edit button click here
        }

        private void RegisterPostBackControls()
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                Page.ClientScript.RegisterForEventValidation(GridView1.UniqueID, "Select$" + row.RowIndex);
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
                string query = "SELECT  * from enquiry WHERE (whatsapp_no LIKE @keyword OR company_name LIKE @keyword OR email LIKE @keyword OR product_name LIKE @keyword OR status LIKE @keyword OR full_name LIKE @keyword ) AND is_delete = 0";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
                DataSet ds = new DataSet();
                da.Fill(ds, "enquiry");
                GridView1.DataSource = ds;
                GridView1.DataBind();
                con.Close();
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
                    string query = "SELECT * FROM [enquiry] WHERE is_delete = 0";

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

