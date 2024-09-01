using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Contracts;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Lead_form : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        SqlCommand cmd = new SqlCommand();
        long marketing_id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    bindProductdropdown();
                    if (Session["username"] != null)
                    {
                        string username = Session["username"].ToString();
                        long marketing_id = GetMarketingIDByUsername(username);
                        Session["marketing_id"] = marketing_id;
                    }

                    BindGridViewData();
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void bindProductdropdown()
        {
            string query = "SELECT product_name FROM product WHERE is_deleted = 0";
            SqlCommand command = new SqlCommand(query, con);
            Ddlproductname.Items.Clear();
            con.Open();
            Ddlproductname.Items.Add(new ListItem("Select", ""));

            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    string productName = reader["product_name"].ToString();
                    Ddlproductname.Items.Add(new ListItem(productName, productName));
                    Ddlproductname.AppendDataBoundItems = true;
                }
            }
            con.Close();
        }

        protected void btnSaveChanges_Click1(object sender, EventArgs e)
        {
            try
            {

                // Save the form data to the database
                SaveFormData();

                // Rebind GridView data after saving
                BindGridViewData();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void BindGridViewData()
        {
            try
            {
                if (Session["marketing_id"] != null)
                {
                    int marketing_id = Convert.ToInt32(Session["marketing_id"]);
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    DataTable dt = GetDataFromDatabase();

                    // Bind the DataTable to the GridView
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }

                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }
        private string GetLocalIpAddress()
        {
            string localIpAddress = "";

            System.Net.NetworkInformation.NetworkInterface[] networkInterfaces = System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces();

            foreach (System.Net.NetworkInformation.NetworkInterface networkInterface in networkInterfaces)
            {
                if (networkInterface.OperationalStatus == System.Net.NetworkInformation.OperationalStatus.Up &&
                    networkInterface.NetworkInterfaceType != System.Net.NetworkInformation.NetworkInterfaceType.Loopback)
                {
                    System.Net.NetworkInformation.IPInterfaceProperties ipProperties = networkInterface.GetIPProperties();
                    foreach (System.Net.NetworkInformation.UnicastIPAddressInformation ip in ipProperties.UnicastAddresses)
                    {
                        if (ip.Address.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                        {
                            localIpAddress = ip.Address.ToString();
                            break;
                        }
                    }
                    if (!string.IsNullOrEmpty(localIpAddress))
                    {
                        break;
                    }
                }
            }

            return localIpAddress;
        }
        private void SaveFormData()
        {
            try
            {
                
                    // Retrieve form data
                    string full_name = txtName.Text.Trim();
                    string company_name = txtCompany.Text.Trim();
                    string product_name = Ddlproductname.SelectedItem.Text;
                    string Whatsapp_no = txtwhatsappno.Text.Trim();
                    string email = txtEmail.Text.Trim();
                    string description = txtdescription.Text.Trim();
                    string status = "Pending";  // Assuming default status is "New"

                    // Save the form data to the database
                    // Replace this with your actual database query to insert data into the database
                    InsertFormDataIntoDatabase(full_name, company_name, product_name, Whatsapp_no, email, description, status);
                
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }
        private DataTable GetDataFromDatabase()
        {

            int marketing_id = Convert.ToInt32(Session["marketing_id"]);

            // Check if marketing_id is valid
            if (marketing_id <= 0)
            {
                // Handle the situation when marketing_id is not valid
                Response.Write("<script>alert('Invalid marketing_id');</script>");

            }
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {

                string query = "SELECT [lead_id], [full_name], [company_name], [email], [Whatsapp_no], [description], [status] FROM [lead] where marketing_id=@marketing_id AND is_delete=0";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    cmd.Parameters.AddWithValue("marketing_id", marketing_id);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                }

            }
            return dt;

        }
        private bool CheckEmailExists(string email)
        {
            bool exists = false;
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM client WHERE email = @email", con);

            cmd.Parameters.AddWithValue("@email", email);

            try
            {
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                exists = count > 0;
            }
            catch (Exception ex)
            {
                // Handle exceptions, such as logging or displaying an error message
                // For example:
                // Response.Write($"Error: {ex.Message}");
                exists = false; // Indicate that the existence check failed due to an error
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return exists;
        }

        private void InsertFormDataIntoDatabase(string full_name, string company_name, string product_name, string Whatsapp_no, string email, string description, string status)
        {
            try
            {
                bool emailExists = CheckEmailExists(txtEmail.Text);

                if (emailExists)
                {
                    Response.Write("<script>alert('Email already exists.');</script>");
                    return; // Exit the method without inserting the lead
                }
                else
                {
                    int marketing_id = Convert.ToInt32(Session["marketing_id"]);

                    // Check if marketing_id is valid
                    if (marketing_id <= 0)
                    {
                        // Handle the situation when marketing_id is not valid
                        Response.Write("<script>alert('Invalid marketing_id');</script>");
                        return;
                    }

                    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
                    // using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string storedProcedureName = "ManageLead";
                        //string status = "Pending";

                        using (SqlCommand cmd = new SqlCommand(storedProcedureName, conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;


                            //SqlCommand cmd = new SqlCommand("INSERT INTO [lead] ([full_name], [company_name], [product_name],[Whatsapp_no], [email], [description], [status],ip_address,latitude,longitude,pc_name,is_delete,created_by,created_date,user_time,marketing_id,operation) " +
                            //"VALUES (@FullName, @CompanyName, @ProductName, @WhatsappNo, @Email, @Description, @Status,@ip_address,@latitude,@longitude,@pc_name,@is_delete,@created_by,@created_date,@user_time,@marketing_id,@Operation)", conn);
                            cmd.Parameters.AddWithValue("@Operation", "InsertLead");
                            cmd.Parameters.AddWithValue("@full_name", full_name);
                            cmd.Parameters.AddWithValue("@company_name", company_name);
                            cmd.Parameters.AddWithValue("@product_name", product_name);
                            cmd.Parameters.AddWithValue("@Whatsapp_no", Whatsapp_no);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@Description", description);
                            cmd.Parameters.AddWithValue("@status", status);
                            cmd.Parameters.AddWithValue("@marketing_id", marketing_id);


                            //Script            
                            cmd.Parameters.AddWithValue("@ip_address", GetLocalIpAddress());
                            cmd.Parameters.AddWithValue("@pc_name", Environment.MachineName);
                            cmd.Parameters.AddWithValue("@latitude", Request.Form["latitude"]);
                            cmd.Parameters.AddWithValue("@longitude", Request.Form["longitude"]);
                            cmd.Parameters.AddWithValue("@is_delete", 0);
                            cmd.Parameters.AddWithValue("@created_by", Session["username"]);
                            cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                            cmd.Parameters.AddWithValue("@user_time", DateTime.Now);

                            conn.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();

                            conn.Close();

                            if (rowsAffected != 0)
                            {
                                Response.Write("<script>alert('Lead Added successfully');</script>");
                                BindGridViewData();
                            }
                            else
                            {
                                Response.Write("<script>alert('Lead add failed');</script>");
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

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGridViewData(); // Rebind the data to reflect the edit mode
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int lead_id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["lead_id"]);
            DropDownList ddlStatus = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList1");

            // Update the status for the lead with lead_id
            UpdateLeadStatus(lead_id, ddlStatus.SelectedValue);

            GridView1.EditIndex = -1; // Exit edit mode
            BindGridViewData(); // Rebind the data after update
        }

        private void UpdateLeadStatus(int lead_id, string status)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("UPDATE [lead] SET status = @status WHERE lead_id = @lead_id", conn);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@lead_id", lead_id);
                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();

                conn.Close();

                if (rowsAffected != 0)
                {
                    Response.Write("<script>alert('Lead status updated  successfully');</script>");
                    BindGridViewData();
                }
                else
                {
                    Response.Write("<script>alert('failed to status update');</script>");
                }
            }
        }



        private long GetMarketingIDByUsername(string username)
        {
            long Marketing_id = 0; // Default value if no match is found
            try
            {
                con.Open();

                string query = "SELECT marketing_id FROM marketing WHERE marketing_username = @username";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@username", username);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Use GetInt64 for bigint type
                            marketing_id = reader.GetInt64(0);
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

            return marketing_id;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    if (Session["marketing_id"] != null)
                    {
                        int marketing_id = Convert.ToInt32(Session["marketing_id"]);
                        string query = "SELECT * FROM [lead] WHERE is_delete = 0 AND marketing_id=@marketing_id";
                        
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
                        conn.Open();
                        cmd.Parameters.AddWithValue("marketing_id", marketing_id);
                        // Set parameters for date range if necessary
                        if (selectedValue == "today")
                        {
                            cmd.Parameters.AddWithValue("@StartDate", DateTime.Today);
                            cmd.Parameters.AddWithValue("@EndDate", DateTime.Today.AddDays(1));
                        }

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();

                       
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
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
