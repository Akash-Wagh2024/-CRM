using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Client_productReply : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string clientID = Session["ClientID"].ToString();
                databind(clientID); // Pass clientID to databind method
            }
        }

        private void databind(string clientID) // Accept clientID as parameter
        {
            using (SqlCommand cmd = new SqlCommand("select * from product_alert where client_id=@client_id", con))
            {
                cmd.Parameters.AddWithValue("@client_id", clientID); // Use correct case for clientID
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }
    }
}