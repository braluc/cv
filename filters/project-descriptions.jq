[.projects
 | to_entries
 | map({ key: .key,
         value: (.value
                 | . +
                   { content: (try readfile("content/text/" + .key + ".html")
                               catch "File not found") 
                   }) })]