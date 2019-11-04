using System;
using System.Collections;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Collections.Generic;

namespace VisualWebPartProject2016.VisualWebPart1
{
    public class TaskItem
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public SPFieldUserValueCollection MultiUserColumn { get; set; }
        public SPFieldUserValue SingleUserColumn { get; set; }
        public DateTime Created { get; set; }
        public SPFieldUserValue Author { get; set; }
    }

    public partial class VisualWebPart1UserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDefaultData(18);
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            try
            {
                var lstPeoples = peoplePickerMultiple.AllEntities;

                SPWeb mySite = SPContext.Current.Web;
                SPListItemCollection listItems = mySite.Lists["peoplePickerTestList"].Items;
                
                SPListItem item = listItems.Add();
                item["Title"] = "Title 1002";

                var pickerEntities = peoplePickerMultiple.AllEntities;
                var userCollection = new SPFieldUserValueCollection();
                foreach (var entity in pickerEntities)
                {
                    Console.WriteLine(entity);
                    var userName = entity.Description;
                    var ensureUser = mySite.EnsureUser(userName);                    
                    SPFieldUserValue UserName = new SPFieldUserValue(mySite, ensureUser.ID, ensureUser.LoginName);
                    userCollection.Add(UserName);
                }

                item["multiUserColumn"] = userCollection;
                item.Update();


                var spAccounts = spPeoplePicker.Entities;
                var spUserCollection = new SPFieldUserValueCollection();
                
            }
            catch (Exception ex)
            {
                throw ex;
            }            
        }

        protected void LoadDefaultData(int itemId)
        {
            try
            {
                if (itemId > 0)
                {
                    var site = new SPSite(SPContext.Current.Site.Url);
                    using (SPWeb web = site.OpenWeb())
                    {
                        SPList listDailyTask = web.Lists["peoplePickerTestList"];
                        var taskItem = FindTaskById(listDailyTask, itemId);
                        txtTitle.Text = taskItem.Id.ToString() + taskItem.Title;

                        // set values for MultiUserColumn
                        foreach (var uItem in taskItem.MultiUserColumn)
                        {
                            var assignedName = uItem.User.Name;
                            var assignedPicker = new PeopleEditor();
                            var assignedEntity = new PickerEntity { Key = assignedName };
                            assignedEntity = assignedPicker.ValidateEntity(assignedEntity);
                            assignedEntity.IsResolved = true;
                            peoplePickerMultiple.AddEntities(new List<PickerEntity> { assignedEntity });
                        }

                        // set values for SingleUserColumn
                        if (taskItem.SingleUserColumn != null)
                        {
                            var assignedName1 = taskItem.SingleUserColumn.User.Name;
                            var assignedPicker1 = new PeopleEditor();
                            var assignedEntity1 = new PickerEntity { Key = assignedName1 };
                            assignedEntity1 = assignedPicker1.ValidateEntity(assignedEntity1);
                            assignedEntity1.IsResolved = true;
                            peoplePickerSingle.AddEntities(new List<PickerEntity> { assignedEntity1 });
                        }
                        web.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected TaskItem FindTaskById(SPList list, int itemId)
        {
            try
            {
                var taskItem = new TaskItem();
                var spItem = list.GetItemById(itemId);
                if (spItem != null)
                {
                    taskItem = new TaskItem
                    {
                        Id = spItem["ID"] == null ? 0 : Convert.ToInt32(spItem["ID"].ToString()),
                        Title = spItem["Title"] == null ? string.Empty : spItem["Title"].ToString(),
                        Created =
                            spItem["Created"] == null
                                ? DateTime.Now
                                : Convert.ToDateTime(spItem["Created"].ToString()),
                    };
                                        
                    var multiUserColumn = spItem["multiUserColumn"] as SPFieldUserValueCollection;                    
                    var singleUserColumn = spItem["singleUserColumn"].ToString();
                    var singleUserColumn1 = GetSPUserAccount(singleUserColumn);

                    taskItem.MultiUserColumn = multiUserColumn;
                    taskItem.SingleUserColumn = singleUserColumn1;                                       
                }
                return taskItem;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected SPFieldUserValue GetSPUserAccount(string spUserName)
        {
            try
            {
                var spADUserAccount = new SPFieldUserValue();
                int index = spUserName.LastIndexOf(";#", System.StringComparison.Ordinal);
                if (index != -1)
                {
                    var userId = Convert.ToInt32(spUserName.Substring(0, index));
                    string userLoginName = spUserName.Remove(0, index + 2);
                    spADUserAccount = new SPFieldUserValue(SPContext.Current.Web, userId, userLoginName);
                }
                return spADUserAccount;
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }
    }
}
