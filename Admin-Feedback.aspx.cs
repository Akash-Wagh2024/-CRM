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
    public partial class Admin_Feedback : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
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
        private void BindGridView()
        {

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString()))
            using (SqlCommand cmd = new SqlCommand("ManageFeedback", con))
            {
                try
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "Details");

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        DataTable distinctDataTable = dt.DefaultView.ToTable(true);
                        GridView1.DataSource = distinctDataTable;
                        GridView1.DataBind();
                    }
                    con.Close();
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Reply")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                string clientId = GridView1.DataKeys[rowIndex].Value.ToString();

                Response.Redirect("FeedbackReply.aspx?username=" + clientId);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btnEdit = (LinkButton)sender;
                GridViewRow row = (GridViewRow)btnEdit.NamingContainer;
                HiddenField hfticket_id = (HiddenField)row.FindControl("hfticket_id");

                string feedback_id = hfticket_id.Value;

                //string feedback_id = row.Cells[0].Text;
                string client_username = row.Cells[1].Text;
                string rating = row.Cells[2].Text;
                string comment = row.Cells[3].Text;
                string description = row.Cells[5].Text;

                Response.Redirect("FeedbackReply.aspx?feedback_id=" + feedback_id +
                    "&client_username=" + Server.UrlEncode(client_username) +
                     "&rating=" + Server.UrlEncode(rating) +
                    "&comment=" + Server.UrlEncode(comment) +
                    "&description=" + Server.UrlDecode(description));
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hfticket_id = (HiddenField)e.Row.FindControl("hfticket_id");
                hfticket_id.Value = DataBinder.Eval(e.Row.DataItem, "feedback_id").ToString();

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

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            
            GridViewRow selectedRow = GridView1.SelectedRow;

            string selectedData = selectedRow.Cells[0].Text; 

            

        }
        

    }

}