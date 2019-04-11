from flask import Flask,render_template,request,redirect,make_response,session
import pymysql
from code import code

app = Flask(__name__)
app.secret_key="123456"

def connect():
    db = pymysql.connect('localhost', 'root', '123456', 'hisexcel', charset='utf8',
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
    if (session.get("code") == request.form["code"].lower()):
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
    else:
        return render_template('login.html',data={'tips':'验证码错误'})
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

# 查看已录入合同
@app.route('/history')
def history():
    create_userid = session.get("userid");
    db = connect()
    cur = db.cursor()
    cur.execute("select 合同编号,客户名称,业务类型,产品名称,负责销售,销售所属分公司,首次启动人数,项目启动日期,客服经理,客户代理人 from mainform where create_userid = %s and state = 1",(create_userid))
    mainform = cur.fetchall()
    cur.execute("select 合同编号,工资报税地,工资到款日,工资发放日,工资发放类型,薪税需求备注 from salaryform where create_userid = %s and state = 1", (create_userid))
    salaryform = cur.fetchall()
    cur.execute("select 合同编号,社保缴纳城市,不收取残保金城市,社保到款日,是否涉及异地参保 from securityform where create_userid = %s and state = 1", (create_userid))
    securityform = cur.fetchall()
    db.close()
    cur.close()
    return render_template('history.html',mainform=mainform,salaryform=salaryform,securityform=securityform)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
