using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class Admin_Product_Alert : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                databind();
            }
        }

        private void databind()
        {
            using (SqlCommand cmd = new SqlCommand("select * from product_alert", con))
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {

            LinkButton btnEdit = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btnEdit.NamingContainer;
            HiddenField hfalert_id = (HiddenField)row.FindControl("hfalert_id");
            string alert_id = hfalert_id.Value;
            Response.Redirect("Admin_Product_AlertReply.aspx?alert_id=" + alert_id);
        }
    }
}