using System;

namespace suxiang.Model
{
    public class QuestionModel
    {
        public int Id { get; set; }
        public int Projectid { get; set; }
        public string Projectname { get; set; }
        public string BuildingNo { get; set; }
        public string Levelno { get; set; }
        public string Location { get; set; }
        public string Problemdescription { get; set; }
        public string Responsibleperson { get; set; }
        public DateTime Checkdate { get; set; }
        public string Worker { get; set; }
        public string Rebuilder { get; set; }
        public DateTime Finishdate { get; set; }
        public string Worktimecost { get; set; }
        public string Materialcost { get; set; }
        public string ProblemType { get; set; }
        public string Poster { get; set; }
        public DateTime Posttime { get; set; }
    }
}