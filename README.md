
## Download the stackoverflow.com-*.7z files

From https://archive.org/details/stackexchange, download the individual stackoverflow.com site data
files.
They are under the 7Z files in the DOWNLOAD OPTIONS box.

These are 
```
https://archive.org/download/stackexchange/stackoverflow.com-Badges.7z
```
and there are files for Badges, Comments, PostHistory, PostLinks, Posts, Tags, Users and Votes


```{bash}
for f in Badges Comments PostHistory PostLinks Posts Tags Users Votes ; do
 echo $f
 curl -O https://archive.org/download/stackexchange/stackoverflow.com-$f.7z
done
```

Be aware that these total 40 Gigabytes as compressed files.
See below for processing each file in one step to reduce disk space usage.

## Extract the Individual XML Files
```{bash}
for f in stackoverflow.com*7z ; do echo $f; 7za x $f ; done
```


## Convert the XML to CSV
To convert any of the XML files to CSV format, you can use the command, e.g.,
```
make Badges.csv
```
Alternatively, you can create all of the CSV files from the XML files using 
```
make
```
These commands use the GNUmakefile in this directory where we added rules 
about how to convert the XML.

This approach uses our sax2csv command available at [https://github.com/dsidavis/SAX2CSV](https://github.com/dsidavis/SAX2CSV).
This uses an event-driven/streaming XML parser since the XML files are very large.
This essentially reads each XML element and processes it and then discards it to move onto the next
one. 

For each XML element, we generate one row in the CSV file.
We can tell sax2csv which attributes to extract from the XML and add as a column in the CSV.
These must be the same for all rows. 
We can provide the names of the attributes as command line arguments for sax2csv.
Alternatively, we can have sax2csv make a pass over the entire XML document and list all of
the attributes it encounters. We can then use these in a second pass as the attributes of interest.

Alternatively, we can get the attributes for each of the 8 files schema from
https://ia800107.us.archive.org/27/items/stackexchange/readme.txt
We can then explicitly list those.
Unfortunately, these seem incomplete. There are some attributes in the XML that are not listed
in this schema. Similarly, there are some attributes listed here that do not appear in the XML.
We check this using the R code in checkVar

When sax2csv encouters an XML element without a particular attribute, it inserts an NA for that
cell (row-column combination) in the CSV file.


```
../../SAX2CSV/sax2csv Badges.xml Badges.csv Id UserId Name Date Class TagBased
```
This takes about 50 seconds for 29,307,838 records.

PostLinks takes 20 seconds for 5,497,178 records.
Tags takes .32 seconds for 53,806 records.



## Limited Disk Space

If disk space is a concern, you can "fuse" the loops so that you
download a 7z file, extract the XML file,  remove the 7z file, convert the XML to a CSV and then remove the 
XML file.



It takes almost 6 minutes to read Badges.csv.






#
Id Tags Table

We create a new table which contains a row for each Post Id and each Tag.
This splits the Tags string in a record in the Posts.xml into multiple rows.
So an entry such as
```
"6"	"<html><css><css3><internet-explorer-7>"
```
becomes
```
Id	Tags
6	html
6	css
6	css3
6	internet-explorer-7
```

```
../../SAX2CSV/sax2csv --tags Posts.xml PostsIdTable.tsv  Id Tags
```



There are 53,810 unique tags. The frequency for each is in TagCounts. See the top 500 tags below.

###  Mapping from TypeIds to Descroptions
+ Votes.csv/xml
   + The VoteTypeId maps to a table of explanations/descriptions in VoteTypeId.csv
+ PostLinks.csv/xml
   + PostLinkTypeId maps to a table in PostLinkTypeId.csv
+ PostHistory.csv/xml
   + PostHistoryTypeId maps in PostHistoryTypeId.csv
   + We don't have the CloseReasonId field in our dumps, but the map fromn Id to reason is in CloseReasonId.csv
+ Posts.xml/csv
   + PostTypeId map in PostTypeId.csv
   








# Tag Counts
```{r}
head(sort(tagCounts, decreasing = TRUE), 500)
                javascript                       java 
                   1723695                    1487204 
                        c#                        php 
                   1264937                    1245632 
                   android                     python 
                   1154987                    1068646 
                    jquery                       html 
                    936253                     789763 
                       c++                        ios 
                    595966                     584127 
                       css                      mysql 
                    563810                     541850 
                       sql                    asp.net 
                    468828                     340548 
             ruby-on-rails                          c 
                    300042                     290823 
               objective-c                     arrays 
                    286275                     281584 
                      .net                          r 
                    276854                     265946 
                 angularjs                    node.js 
                    256055                     252581 
                      json                 sql-server 
                    249683                     247633 
                    iphone                      swift 
                    219808                     214563 
                      ruby                      regex 
                    200338                     198963 
                      ajax                     django 
                    194189                     185007 
                     excel                        xml 
                    182651                     178523 
               asp.net-mvc                      linux 
                    176230                     170988 
                  database                        wpf 
                    150923                     145754 
                    spring                    angular 
                    143219                     142653 
                 wordpress                        vba 
                    142199                     135135 
                    string                 python-3.x 
                    133964                     131941 
                     xcode                    windows 
                    129187                     125473 
                    vb.net                      html5 
                    121043                     117178 
                   eclipse                    reactjs 
                    114941                     112282 
            multithreading                    mongodb 
                    112077                     106965 
                      bash                        git 
                    106039                     105431 
                    oracle                    laravel 
                    104151                     103077 
         twitter-bootstrap                 postgresql 
                     93550                      92787 
                     forms                      image 
                     91927                      90980 
                     macos                     pandas 
                     88840                      88281 
                 algorithm                 python-2.7 
                     88182                      87227 
                     scala              visual-studio 
                     84840                      84164 
                 excel-vba                   facebook 
                     84079                      82951 
                  winforms                     apache 
                     82469                      82460 
                      list                     matlab 
                     82075                      81429 
               performance           entity-framework 
                     80201                      77237 
                      css3                  hibernate 
                     76835                      74753 
                      linq                      swing 
                     72150                      71744 
                  function                         qt 
                     70316                      68417 
                typescript                       rest 
                     68302                      67570 
                     shell        amazon-web-services 
                     67449                      67211 
                     maven                  .htaccess 
                     64659                      64356 
                       api                      azure 
                     64301                      64061 
                    sqlite                 powershell 
                     63809                      62981 
                      file                   firebase 
                     61703                      61692 
               codeigniter                       perl 
                     61516                      61061 
              unit-testing                    symfony 
                     60472                      59639 
                     loops                google-maps 
                     59382                      58981 
              web-services                uitableview 
                     58753                      58428 
                       csv                    cordova 
                     58129                      57759 
                  selenium                      class 
                     57484                      57050 
           ruby-on-rails-3              google-chrome 
                     55890                      55834 
                validation                      numpy 
                     54824                      54343 
                   sorting                       tsql 
                     54315                      54295 
                   sockets                       date 
                     54077                      53676 
            android-studio            sql-server-2008 
                     53034                      52726 
                      xaml             android-layout 
                     51481                      50867 
                      http                 spring-mvc 
                     50817                      49842 
                     email                        wcf 
                     49182                      49008 
                       jsp                spring-boot 
                     48781                      48398 
                    docker                    express 
                     48217                      47769 
                  listview                     opencv 
                     47684                      47422 
        visual-studio-2010                        oop 
                     46621                      46618 
                  security                   datetime 
                     46375                      46136 
              apache-spark                      c++11 
                     46062                      45872 
                   parsing             user-interface 
                     45325                      44477 
                dictionary                 batch-file 
                     43485                      43143 
                    ubuntu                     delphi 
                     43142                      42757 
         google-app-engine                     object 
                     42292                      42251 
              react-native                  dataframe 
                     42205                      41809 
                 templates                   pointers 
                     41738                      41677 
             asp.net-mvc-4                   for-loop 
                     41564                      41380 
            actionscript-3                  variables 
                     41194                      40730 
                 ms-access                  debugging 
                     40668                      40659 
                      unix                    session 
                     39962                      39531 
                    hadoop               if-statement 
                     39375                      39370 
                   haskell              asp.net-mvc-3 
                     39192                      38657 
                 jquery-ui             authentication 
                     38477                      38221 
         android-fragments                      cocoa 
                     38118                      37943 
                       pdf                    unity3d 
                     37852                      37668 
                   magento          internet-explorer 
                     37316                      37315 
                       ssl                     tomcat 
                     37289                      37208 
                       jpa            ruby-on-rails-4 
                     36329                      36119 
                  generics                 tensorflow 
                     36038                      35846 
                       web              elasticsearch 
                     35788                      35787 
                     flash                        url 
                     35281                      35118 
                 animation                 matplotlib 
                     35004                      34681 
                      ipad                cocoa-touch 
                     34442                      34423 
                        go                    xamarin 
                     34254                      34240 
              asynchronous                        jsf 
                     34159                      33939 
                   firefox                      nginx 
                     33902                      33861 
                      curl                   redirect 
                     33690                      33462 
                   testing         facebook-graph-api 
                     33319                      33017 
               inheritance                     winapi 
                     32778                      32700 
                   jenkins                  exception 
                     32663                      32119 
                      post                      d3.js 
                     32022                      31862 
           ionic-framework                     events 
                     31774                      31615 
                    opengl                       xslt 
                     31615                      31559 
                 recursion                       math 
                     31494                      31446 
                       dom                       join 
                     31321                      31260 
                   caching                     select 
                     31186                      31118 
                       iis                     github 
                     30963                      30888 
                    button                   servlets 
                     30850                      30803 
                       gcc         selenium-webdriver 
                     30517                      30499 
                 laravel-5                     search 
                     30372                      30325 
                    gradle            asp.net-web-api 
                     30324                      30303 
               mod-rewrite           image-processing 
                     30179                      30098 
                   cakephp                        svg 
                     30084                      29962 
         stored-procedures                     heroku 
                     29775                      29672 
                   logging                   assembly 
                     29657                      29550 
                    matrix                     canvas 
                     29438                      28937 
                networking                      audio 
                     28892                      28890 
             intellij-idea                     grails 
                     28546                      28482 
                   java-ee                      video 
                     28327                      28310 
                     xpath                 encryption 
                     28297                      28168 
                    meteor                     javafx 
                     27992                      27839 
                    memory           machine-learning 
                     27781                      27523 
               silverlight             android-intent 
                     27506                      27380 
              optimization                      razor 
                     27356                      27344 
                   cookies                     iframe 
                     27324                      27172 
     model-view-controller                  amazon-s3 
                     26507                      26496 
                 arraylist                       jdbc 
                     26495                      26422 
                    vue.js                 visual-c++ 
                     26392                      26255 
           design-patterns                     mysqli 
                     26244                      26154 
             serialization           android-activity 
                     26141                      26030 
    multidimensional-array               activerecord 
                     25874                      25756 
                    vector                  core-data 
                     25668                      25657 
                       svn                    ggplot2 
                     25644                      25411 
                  gridview                     c#-4.0 
                     25193                      25162 
                    random                      flask 
                     25067                      24909 
                  checkbox               asp.net-core 
                     24844                      24619 
                      soap                       plot 
                     24470                      24465 
                    mobile                       flex 
                     24414                      24303 
                     input                 sharepoint 
                     24211                      24010 
                      text          google-maps-api-3 
                     23908                      23715 
firebase-realtime-database                        npm 
                     23605                      23570 
                  indexing                        vim 
                     23554                      23527 
                   webpack                       mvvm 
                     23385                      23345 
                     extjs                   mongoose 
                     23335                      23193 
                amazon-ec2         visual-studio-2012 
                     23156                      23085 
                     boost                    methods 
                     23082                      23070 
                       awk                     layout 
                     23031                      22963 
         memory-management                file-upload 
                     22962                      22961 
                  ember.js              jquery-mobile 
                     22936                      22810 
                   tkinter            data-structures 
                     22536                      22440 
                   twitter                    dynamic 
                     22221                      22066 
             django-models                     groovy 
                     22003                      21972 
                  netbeans         google-apps-script 
                     21935                      21724 
                       dll                    browser 
                     21677                      21593 
                       pdo         reporting-services 
                     21317                      21175 
                      time                     struct 
                     21140                      21126 
                       ssh                        sed 
                     21013                      20879 
                   plugins                     lambda 
                     20849                      20644 
               backbone.js            database-design 
                     20574                      20560 
                       gwt                    unicode 
                     20527                      20513 
                reflection        twitter-bootstrap-3 
                     20483                      20387 
            zend-framework                      graph 
                     20360                      20062 
   google-chrome-extension                    replace 
                     19936                      19914 
           windows-phone-7                     charts 
                     19885                      19755 
              data-binding                      junit 
                     19721                      19674 
                      hash                    service 
                     19584                      19556 
                     plsql                 highcharts 
                     19523                      19432 
               knockout.js                   encoding 
                     19404                      19382 
              web-scraping         visual-studio-2015 
                     19214                      19151 
           spring-security                  parse.com 
                     19142                      19079 
                   file-io                        tfs 
                     19004                      18975 
                    drupal           web-applications 
                     18973                      18848 
               collections                     filter 
                     18839                      18794 
        visual-studio-2013                      https 
                     18776                      18748 
                   foreach                     design 
                     18736                      18711 
                nhibernate               command-line 
                     18592                      18587 
            drop-down-menu                      login 
                     18531                      18529 
                       cmd            windows-phone-8 
                     18520                      18420 
                    swift3                      utf-8 
                     18383                      18372 
                     types                 deployment 
                     18362                      18343 
                  printing            sql-server-2005 
                     18338                      18330 
      dependency-injection                woocommerce 
                     18325                      18300 
                  makefile               ecmascript-6 
                     18288                      18178 
                    paypal                        tcp 
                     18133                      17857 
                   webview                 primefaces 
                     17850                      17780 
                    import                       solr 
                     17764                      17739 
              datagridview                     scroll 
                     17635                      17546 
                      view              xamarin.forms 
                     17467                      17463 
            error-handling                 html-table 
                     17452                      17452 
                    uiview        angularjs-directive 
                     17432                      17136 
                while-loop                  websocket 
                     17108                      16963 
                     neo4j                     kotlin 
                     16954                      16943 
                  vbscript       android-recyclerview 
                     16895                      16872 
                  graphics                  oracle11g 
                     16831                      16726 
               concurrency                     syntax 
                     16630                      16627 
                     redux               memory-leaks 
                     16588                      16498 
                     fonts              google-sheets 
                     16472                      16455 
                     merge                      oauth 
                     16453                      16447 
          google-analytics                        yii 
                     16427                      16407 
                 datatable                      build 
                     16377                      16361 
                     rspec                 parameters 
                     16185                      16147 
                     enums                      timer 
                     16111                      16060 
                     emacs                     colors 
                     16057                      16037 
             playframework                constructor 
                     16035                      15981 
             excel-formula                     ffmpeg 
                     15966                      15951 
                     jsf-2                        jar 
                     15939                      15856 
                      ssis                      split 
                     15848                      15762 
        visual-studio-2008                     server 
                     15744                      15646 
                      sass                     module 
                     15565                      15554 
                 doctrine2                   terminal 
                     15524                      15508 
                       orm                   combobox 
                     15488                      15444 
                 hyperlink                       hive 
                     15406                      15350 
                 cassandra                  interface 
                     15321                      15281 
                   sqlite3                   group-by 
                     15241                      15217 
                   casting                    clojure 
                     15211                      15150 
          uiviewcontroller                     java-8 
                     15147                      15072 
                     proxy                     joomla 
                     15008                      14971 
                     redis                 properties 
                     14958                      14945 
           sql-server-2012            version-control 
                     14928                      14921 
          android-listview                       ios7 
                     14915                      14829 
                       lua                    process 
                     14814                      14809 
         javascript-events                        ant 
                     14770                      14703 
       parallel-processing          push-notification 
                     14674                      14649 
                  kendo-ui                        uwp 
                     14643                      14600 
                   binding                      cmake 
                     14530                      14492 
                  triggers         exception-handling 
                     14489                      14486 
             configuration                  laravel-4 
                     14393                      14363 
                     count              url-rewriting 
                     14327                      14278 
                        io              asp.net-mvc-5 
                     14268                      14264 
           compiler-errors                linq-to-sql 
                     14190                      14177 
                    bitmap                  oauth-2.0 
                     14137                      14054 
              autocomplete          responsive-design 
                     14053                      13992 
                 socket.io                      scope 
                     13974                      13952 
                  download                 phpmyadmin 
                     13921                      13916 
      nullpointerexception                   callback 
                     13891                      13890 
                     model          android-asynctask 
                     13888                      13863 
                 bluetooth                     safari 
                     13836                      13811 
                  datagrid                       menu 
                     13803                      13769 
                    devise                   three.js 
                     13751                      13750 
                      path                 datatables 
                     13685                      13649 
                datepicker                    outlook 
                     13631                      13612 
                     jboss              beautifulsoup 
                     13581                      13572 
                  eloquent                    promise 
                     13564                      13532 
                 scripting                linked-list 
                     13506                      13459 
                pagination                 google-api 
                     13456                      13424 
              architecture                    youtube 
                     13414                      13409 
                  webforms                 automation 
                     13401                      13364 
                     shiny                compilation 
                     13354                      13348 
                 reference                         3d 
                     13341                      13326 
    functional-programming                permissions 
                     13269                      13269 
                        f#                    ms-word 
                     13246                      13232 
                controller                     static 
                     13201                      13196 
                 opengl-es               scikit-learn 
                     13189                      13128 
                       dns                    arduino 
                     13063                      13041 
            jquery-plugins               linux-kernel 
                     12985                      12985 

```


# Time to Create the TSV Files
```
          minutes
PostHistory 1424
PostLinks    783.38		  
Comments     181 
Votes         49
Badges        11
Users         10
PostLinks      2
Tags           0.0.849
```


To load these into SQLite3, we get the following approximate times

              Minutes
Users.tsv      3 
Votes.tsv     11
Tags.tsv       0
PostLinks.tsv  < 1
Badges.tsv     2

Comments.tsv   7:33    14G



Comments.tsv:81: unescaped " character
Comments.tsv:85: unescaped " character
Comments.tsv:85: unescaped " character
Comments.tsv:85: expected 7 columns but found 6 - filling the rest with NULL
