using System;

namespace suxiang.Model
{
    public class LogModel
    {
        public int Id { get; set; }

        public string EmployeeNo { get; set; }

        public string EmployeeName { get; set; }

        public DateTime ODateTime { get; set; }

        public string Operation { get; set; }

        public string OType { get; set; }
    }
}