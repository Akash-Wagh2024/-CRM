using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace goGst
{
    public partial class assing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFeedbackData();
                if (Session["ticket_id"] != null)
                {
                    // Retrieve ticket_id from session
                    string ticket_id = Session["ticket_id"].ToString();

                    // Fetch support_id based on ticket_id
                    int support_id = GetSupportIdByTicketId(ticket_id);

                    // Do whatever you need to do with support_id, for example:
                    // Display it on the page
                   BindFeedbackData();
                }
                else
                {
                    // Handle the case where ticket_id is not available in session
                }
            }

        }

        private void BindFeedbackData()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("Assing", conn);
                cmd.CommandType = CommandType.StoredProcedure;

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
        // Method to fetch support_id from the database based on ticket_id
        private int GetSupportIdByTicketId(string ticketId)
        {
            int supportId = 0; // Default value or error code

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                using (SqlCommand command = new SqlCommand("SELECT support_id FROM ticket WHERE ticket_id = @ticketId", connection))
                {
                    command.Parameters.AddWithValue("@ticketId", ticketId);
                    connection.Open();
                    var result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        // If result is not null, convert it to int
                        supportId = Convert.ToInt32(result);
                    }
                    connection.Close();
                }
            }

            return supportId;
        }

        protected void btnAction_Click(object sender, EventArgs e)
        {
            // Find the button that was clicked
            Button btnAction = (Button)sender;

            // Find the row that contains the clicked button
            GridViewRow row = (GridViewRow)btnAction.NamingContainer;

            // Find the index of the row
            int rowIndex = row.RowIndex;

            // Retrieve the support_id from the GridView row
            string support_id = GridView1.DataKeys[rowIndex]["support_id"].ToString();

            // Retrieve the ticket_id from the session
            string ticket_id = Session["ticket_id"].ToString();

            // Update the support_id in the database
            UpdateSupportIdForTicketId(ticket_id, support_id);

            // Rebind GridView data after updating
            BindFeedbackData();
        }

        // Method to update support_id for a given ticket_id in the database
        private void UpdateSupportIdForTicketId(string ticketId, string supportId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            {
                using (SqlCommand command = new SqlCommand("UPDATE ticket SET support_id = @supportId WHERE ticket_id = @ticketId", connection))
                {
                    command.Parameters.AddWithValue("@supportId", supportId);
                    command.Parameters.AddWithValue("@ticketId", ticketId);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
        }
    }
}


      