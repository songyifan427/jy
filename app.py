# encoding: utf-8
from flask import Flask,render_template,request,redirect,make_response,session
import pymysql
# from code import code
from config import secret_key
from config import mysqlhost,user,password,dbname,mysqlport

app = Flask(__name__)
app.secret_key=secret_key

def connect():
    db = pymysql.connect(host=mysqlhost , port=mysqlport , user=user , passwd=password, db=dbname, charset='utf8',
                         cursorclass=pymysql.cursors.DictCursor)
    return db

# 访问根目录
@app.route('/')
def index():
    if(session.get("login")=="yes"):
        return render_template('index.html',data={'name':session.get('username')})
    else:
        return  redirect('/login')
# 访问登录页
@app.route('/login')
def login():
    return render_template('login.html')
@app.route('/codeimg')
def codeimg():
    codeobj=code()
    res=make_response(codeobj.output())
    session["code"]=codeobj.str.lower()
    res.headers["content-type"]="image/png"
    return res
# 验证登录
@app.route('/checklogin',methods=["POST"])
def checklogin():
#     if (session.get("code") == request.form["code"].lower()):
#         db = connect()
#         cur = db.cursor()
#         userid=request.form["userid"]
#         password=request.form["password"]
#         cur.execute('select username from userinfo where userid=%s and password=%s',(userid,password))
#         result=cur.fetchone()
#         db.close()
#         cur.close()
#         if(result):
#             res = make_response(redirect('/'))
#             # 登录状态
#             session["login"]="yes"
#             # 用户ID
#             session["userid"]=userid
#             # 用户名
#             session["username"]=result["username"]
#             return res
#         else:
#             return render_template('login.html',data={'tips':'用户名或密码错误'})
#     else:
#         return render_template('login.html',data={'tips':'验证码错误'})
    
    db = connect()
    cur = db.cursor()
    userid=request.form["userid"]
    password=request.form["password"]
    cur.execute('select username from userinfo where userid=%s and password=%s',(userid,password))
    result=cur.fetchone()
    db.close()
    cur.close()
    if(result):
        res = make_response(redirect('/'))
        # 登录状态
        session["login"]="yes"
        # 用户ID
        session["userid"]=userid
        # 用户名
        session["username"]=result["username"]
        return res
    else:
        return render_template('login.html',data={'tips':'用户名或密码错误'})
   
# 退出登录
@app.route('/logout')
def logout():
    res = make_response(redirect('/'))
    session.pop("login")
    session.pop("userid")
    session.pop("username")
    return res
# 修改密码
@app.route('/myinfo')
def myinfo():
    return render_template('setPassword.html')
@app.route('/setPassword',methods=["POST"])
def setPassword():
    password = request.form["password"]
    userid = session.get('userid')
    db = connect()
    cur = db.cursor()
    cur.execute('select * from userinfo where userid=%s and password=%s', (userid, password))
    result = cur.fetchone()
    if(result):
        newpassword = request.form["inputPassword2"]
        cur.execute('update userinfo set password=%s where userid=%s', (newpassword, userid))
        db.commit()
        db.close()
        cur.close()
        return "成功"
    else:
        db.close()
        cur.close()
        return "密码错误"
# 帮助
@app.route('/help')
def help():
    return render_template('help.html')
# 录入历史合同入口
@app.route('/inputcheck')
def inputcheck():
    return render_template('inputcheck.html')
# 渲染表单
@app.route('/inputclass')
def inputclass():
    productTypeList = {"1":"代理","2":"劳务派遣","3":"外包","4":"薪酬","5":"福利"}
    productClsList = {"1":"金柚宝_标准","2":"金柚宝_尊享","3":"金柚宝_尊贵","4":"金柚宝_单立户","5":"金柚宝_尊享单立户","6":"金柚宝_同业","7":"金柚宝_尊享同业","8":"企业社保通_标准","9":"企业社保通_单立户","10":"金柚帮帮","11":"金柚管家","12":"金柚管家_差额","13":"金柚小灵","14":"金柚小秘","15":"金柚多多","16":"金柚康康_商保","17":"金柚康康_体检"}
    type = request.args.get("type")
    cls = request.args.get("cls")
    return render_template('list.html',type=type,cls=cls,typeName=productTypeList[type],clsName=productClsList[cls])
# 上传数据
@app.route('/uploadMainForm',methods=["POST"])
def uploadMainForm():
    data = dict(request.form)
    delkeyList = []
    for key,value in data.items():
        if value=="":
            delkeyList.append(key)
    if len(delkeyList)!=0:
        for item in delkeyList:
            del data[item]
    data.setdefault("create_userid",session.get("userid"))
    keyList = list(data.keys())
    keyList=",".join(keyList)
    valueList=tuple(data.values())
    db = connect()
    cur = db.cursor()
    cur.execute("insert into mainform (" + keyList + ") values ("+ ','.join(['%s' for i in range(len(data))]) +")",valueList)
    db.commit()
    db.close()
    cur.close()
    return "success"

@app.route('/uploadSecurityForm',methods=["POST"])
def uploadSecurityForm():
    data = dict(request.form)
    delkeyList = []
    for key, value in data.items():
        if value == "":
            delkeyList.append(key)
    if len(delkeyList) != 0:
        for item in delkeyList:
            del data[item]
    if len(data) != 0:
        data.setdefault("create_userid", session.get("userid"))
        keyList = list(data.keys())
        keyList = ",".join(keyList)
        valueList = tuple(data.values())
        db = connect()
        cur = db.cursor()
        cur.execute("insert into securityform (" + keyList + ") values (" + ','.join(['%s' for i in range(len(data))]) + ")",valueList)
        db.commit()
        db.close()
        cur.close()
    return "success"

@app.route('/uploadSalaryForm',methods=["POST"])
def uploadSalaryForm():
    data = dict(request.form)
    delkeyList = []
    for key, value in data.items():
        if value == "":
            delkeyList.append(key)
    if len(delkeyList) != 0:
        for item in delkeyList:
            del data[item]
    if len(data) != 0:
        data.setdefault("create_userid", session.get("userid"))
        keyList = list(data.keys())
        keyList = ",".join(keyList)
        valueList = tuple(data.values())
        db = connect()
        cur = db.cursor()
        cur.execute("insert into salaryform (" + keyList + ") values (" + ','.join(['%s' for i in range(len(data))]) + ")",valueList)
        db.commit()
        db.close()
        cur.close()
    return "success"

# 查看已录入合同入口
@app.route('/history')
def history():
    create_userid = session.get("userid");
    db = connect()
    cur = db.cursor()
    cur.execute("select id,合同编号,客户名称,业务类型,产品名称 from mainform where create_userid = %s and state = 1",(create_userid))
    result = cur.fetchall()
    if result:
        return render_template('history.html',result=result)
    else:
        return render_template('history.html')
# 查看已录入合同
@app.route('/historydetail/<cid>')
def historydetail(cid):
    if cid:
        create_userid = session.get("userid")
        db = connect()
        cur = db.cursor()
        cur.execute("select * from mainform where 合同编号 = %s and create_userid = %s and state = 1",(cid,create_userid))
        mainform = cur.fetchall()
        cur.execute("select * from salaryform where 合同编号 = %s and create_userid = %s and state = 1", (cid,create_userid))
        salaryform = cur.fetchall()
        cur.execute("select * from securityform where 合同编号 = %s and create_userid = %s and state = 1", (cid,create_userid))
        securityform = cur.fetchall()
        db.close()
        cur.close()

        if mainform:
            for thisdict in mainform:
                delkeyList = []
                for key, value in thisdict.items():
                    if value == None:
                        delkeyList.append(key)
                if len(delkeyList) != 0:
                    for item in delkeyList:
                        del thisdict[item]

        return render_template('historydetail.html',mainform=mainform,salaryform=salaryform,securityform=securityform)
    else:
        return redirect("/history")
# 删除已录入合同
@app.route('/historydel/<cid>')
def historydel(cid):
    if cid:
        create_userid = session.get("userid")
        db = connect()
        cur = db.cursor()
        cur.execute("update LOW_PRIORITY ignore mainform set state='0' where 合同编号 = %s and create_userid = %s and state = 1",(cid,create_userid))
        cur.execute("update LOW_PRIORITY ignore securityform set state='0' where 合同编号 = %s and create_userid = %s and state = 1",(cid, create_userid))
        cur.execute("update LOW_PRIORITY ignore salaryform set state='0' where 合同编号 = %s and create_userid = %s and state = 1",(cid, create_userid))
        db.commit()
        db.close()
        cur.close()
    return redirect("/history")
# 修改已录入合同
@app.route('/historyedit/<cid>')
def historyedit(cid):
    return cid
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
