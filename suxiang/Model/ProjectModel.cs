using System.Collections.Generic;

namespace suxiang.Model
{
    public class ProjectModel
    {
        public int Id { get; set; }
        public string Projectname { get; set; }
        public int Projectleaderid { get; set; }
        public string Projectleader { get; set; }
        public int Productleaderid { get; set; }
        public string Productleader { get; set; }
        public int Accountantid { get; set; }
        public string Accountant { get; set; }
        public int Constructionleaderid { get; set; }
        public string Constructionleader { get; set; }
        public int Safetyleaderid { get; set; }
        public string Safetyleader { get; set; }
        public int Qualityleaderid { get; set; }
        public string Qualityleader { get; set; }
        public int Storekeeperid { get; set; }
        public string Storekeeper { get; set; }
        public int BuildingTotal { get; set; }
        public bool State { get; set; }
        public List<ProjectInfoModel> Buildings { get; set; }
    }
}