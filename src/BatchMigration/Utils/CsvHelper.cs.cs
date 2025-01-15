using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace BatchMigration
{
    public static class CsvHelper
    {
        public static List<T> ReadCsv<T>(string filePath) where T : class, new()
        {
            var records = new List<T>();
            var properties = typeof(T).GetProperties();

            using (var reader = new StreamReader(filePath))
            {
                string headerLine = reader.ReadLine();
                var headers = headerLine.Split(',');

                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    var values = line.Split(',');
                    var record = new T();

                    for (int i = 0; i < headers.Length; i++)
                    {
                        var property = properties.FirstOrDefault(p => p.Name.Equals(headers[i], StringComparison.OrdinalIgnoreCase));
                        if (property != null)
                        {
                            property.SetValue(record, Convert.ChangeType(values[i], property.PropertyType, CultureInfo.InvariantCulture));
                        }
                    }

                    records.Add(record);
                }
            }

            return records;
        }

        public static void WriteCsv<T>(IEnumerable<T> records, string filePath)
        {
            var properties = typeof(T).GetProperties();

            using (var writer = new StreamWriter(filePath))
            {
                writer.WriteLine(string.Join(",", properties.Select(p => p.Name)));

                foreach (var record in records)
                {
                    var values = properties.Select(p => p.GetValue(record)?.ToString());
                    writer.WriteLine(string.Join(",", values));
                }
            }
        }
    }
}
