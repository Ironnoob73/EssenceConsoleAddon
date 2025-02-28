extends RichTextLabel
# Base
@export var console_size: Vector2 = Vector2(100,30)
@export var USER_Name:String = "@USER"
@export var ShowTextArt:bool = true
@export var CanInput:bool = false
var CurrentMode:String = ""
# Data
@export var commands:Dictionary = {}
@export var fileDirectory:Dictionary = {"home":{},"config":{}}
var current_path:String = "/home"
# Setup text art
var TextArt:Array[String] = [
	"┎┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┒",
	"┇                 ████████        ███◤                        ┇",
	"┇          ▓▓▓▓▓▓▓▓      ██       █                           ┇",
	"┇   ▒▒▒▒▒▒▒▒        ████████      ██◤  ◢██ ◢██ ◢██ ██◣ ◢██ ◢██┇",
	"┇    ▒▒      ▓▓▓▓▓▓▓▓          ██ █    ◥█◣ ◥█◣ █ ◤ █ █ █   █ ◤┇",
	"┇     ▒▒▒▒▒▒▒▒               ███  ███◤ ██◤ ██◤ ███ █ █ ██◤ ███┇",
	"┇   ░░░▒▒                  ███                                ┇",
	"┇ ░░░  ▒▒ ◥██▶   ▬▬▬▬▬ ██████                                 ┇",
	"┇░░     ▒▒ ◢◤      ▓▓▓▓▓    ██    ◢███                  █     ┇",
	"┇ ░░       ▒▒▒▒▒▓▓▓          ██   █                     █     ┇",
	"┇  ░░░░░░▒▒             ████████  █    ◢██ ██◣ ◢██ ◢██  █  ◢██┇",
	"┇        ▒▒      ▓▓▓▓▓▓▓▓         █    █ █ █ █ ◥█◣ █ █  █  █ ◤┇",
	"┇         ▒▒▒▒▒▒▒▒                ███◤ ██◤ █ █ ██◤ ██◤  █◤ ███┇",
	"┖┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┚"
	]
var TextArtThin:Array[String] = [
	"┎┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┒",
	"┇                 ████████       ┇",
	"┇          ▓▓▓▓▓▓▓▓      ██      ┇",
	"┇   ▒▒▒▒▒▒▒▒        ████████     ┇",
	"┇    ▒▒      ▓▓▓▓▓▓▓▓          ██┇",
	"┇     ▒▒▒▒▒▒▒▒               ███ ┇",
	"┇   ░░░▒▒                  ███   ┇",
	"┇ ░░░  ▒▒ ◥██▶   ▬▬▬▬▬ ██████    ┇",
	"┇░░     ▒▒ ◢◤      ▓▓▓▓▓    ██   ┇",
	"┇ ░░       ▒▒▒▒▒▓▓▓          ██  ┇",
	"┇  ░░░░░░▒▒             ████████ ┇",
	"┇        ▒▒      ▓▓▓▓▓▓▓▓        ┇",
	"┇         ▒▒▒▒▒▒▒▒               ┇",
	"┖┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┚"
	]
# Character test
var CommonlyChineseCharacters:String = "一乙二十丁厂七卜人入八九几儿了力乃刀又三于干亏士工土才寸下大丈与万上小口巾山千乞川亿个勺久凡及夕丸么广亡门义之尸弓己已子卫也女飞刃习叉马乡丰王井开夫天无元专云扎艺木五支厅不太犬区历尤友匹车巨牙屯比互切瓦止少日中冈贝内水见午牛手毛气升长仁什片仆化仇币仍仅斤爪反介父从今凶分乏公仓月氏勿欠风丹匀乌凤勾文六方火为斗忆订计户认心尺引丑巴孔队办以允予劝双书幻玉刊示末未击打巧正扑扒功扔去甘世古节本术可丙左厉右石布龙平灭轧东卡北占业旧帅归且旦目叶甲申叮电号田由史只央兄叼叫另叨叹四生失禾丘付仗代仙们仪白仔他斥瓜乎丛令用甩印乐句匆册犯外处冬鸟务包饥主市立闪兰半汁汇头汉宁穴它讨写让礼训必议讯记永司尼民出辽奶奴加召皮边发孕圣对台矛纠母幼丝式刑动扛寺吉扣考托老执巩圾扩扫地扬场耳共芒亚芝朽朴机权过臣再协西压厌在有百存而页匠夸夺灰达列死成夹轨邪划迈毕至此贞师尘尖劣光当早吐吓虫曲团同吊吃因吸吗屿帆岁回岂刚则肉网年朱先丢舌竹迁乔伟传乒乓休伍伏优伐延件任伤价份华仰仿伙伪自血向似后行舟全会杀合兆企众爷伞创肌朵杂危旬旨负各名多争色壮冲冰庄庆亦刘齐交次衣产决充妄闭问闯羊并关米灯州汗污江池汤忙兴宇守宅字安讲军许论农讽设访寻那迅尽导异孙阵阳收阶阴防奸如妇好她妈戏羽观欢买红纤级约纪驰巡寿弄麦形进戒吞远违运扶抚坛技坏扰拒找批扯址走抄坝贡攻赤折抓扮抢孝均抛投坟抗坑坊抖护壳志扭块声把报却劫芽花芹芬苍芳严芦劳克苏杆杠杜材村杏极李杨求更束豆两丽医辰励否还歼来连步坚旱盯呈时吴助县里呆园旷围呀吨足邮男困吵串员听吩吹呜吧吼别岗帐财针钉告我乱利秃秀私每兵估体何但伸作伯伶佣低你住位伴身皂佛近彻役返余希坐谷妥含邻岔肝肚肠龟免狂犹角删条卵岛迎饭饮系言冻状亩况床库疗应冷这序辛弃冶忘闲间闷判灶灿弟汪沙汽沃泛沟没沈沉怀忧快完宋宏牢究穷灾良证启评补初社识诉诊词译君灵即层尿尾迟局改张忌际陆阿陈阻附妙妖妨努忍劲鸡驱纯纱纳纲驳纵纷纸纹纺驴纽奉玩环武青责现表规抹拢拔拣担坦押抽拐拖拍者顶拆拥抵拘势抱垃拉拦拌幸招坡披拨择抬其取苦若茂苹苗英范直茄茎茅林枝杯柜析板松枪构杰述枕丧或画卧事刺枣雨卖矿码厕奔奇奋态欧垄妻轰顷转斩轮软到非叔肯齿些虎虏肾贤尚旺具果味昆国昌畅明易昂典固忠咐呼鸣咏呢岸岩帖罗帜岭凯败贩购图钓制知垂牧物乖刮秆和季委佳侍供使例版侄侦侧凭侨佩货依的迫质欣征往爬彼径所舍金命斧爸采受乳贪念贫肤肺肢肿胀朋股肥服胁周昏鱼兔狐忽狗备饰饱饲变京享店夜庙府底剂郊废净盲放刻育闸闹郑券卷单炒炊炕炎炉沫浅法泄河沾泪油泊沿泡注泻泳泥沸波泼泽治怖性怕怜怪学宝宗定宜审宙官空帘实试郎诗肩房诚衬衫视话诞询该详建肃录隶居届刷屈弦承孟孤陕降限妹姑姐姓始驾参艰线练组细驶织终驻驼绍经贯奏春帮珍玻毒型挂封持项垮挎城挠政赴赵挡挺括拴拾挑指垫挣挤拼挖按挥挪某甚革荐巷带草茧茶荒茫荡荣故胡南药标枯柄栋相查柏柳柱柿栏树要咸威歪研砖厘厚砌砍面耐耍牵残殃轻鸦皆背战点临览竖省削尝是盼眨哄显哑冒映星昨畏趴胃贵界虹虾蚁思蚂虽品咽骂哗咱响哈咬咳哪炭峡罚贱贴骨钞钟钢钥钩卸缸拜看矩怎牲选适秒香种秋科重复竿段便俩贷顺修保促侮俭俗俘信皇泉鬼侵追俊盾待律很须叙剑逃食盆胆胜胞胖脉勉狭狮独狡狱狠贸怨急饶蚀饺饼弯将奖哀亭亮度迹庭疮疯疫疤姿亲音帝施闻阀阁差养美姜叛送类迷前首逆总炼炸炮烂剃洁洪洒浇浊洞测洗活派洽染济洋洲浑浓津恒恢恰恼恨举觉宣室宫宪突穿窃客冠语扁袄祖神祝误诱说诵垦退既屋昼费陡眉孩除险院娃姥姨姻娇怒架贺盈勇怠柔垒绑绒结绕骄绘给络骆绝绞统耕耗艳泰珠班素蚕顽盏匪捞栽捕振载赶起盐捎捏埋捉捆捐损都哲逝捡换挽热恐壶挨耻耽恭莲莫荷获晋恶真框桂档桐株桥桃格校核样根索哥速逗栗配翅辱唇夏础破原套逐烈殊顾轿较顿毙致柴桌虑监紧党晒眠晓鸭晃晌晕蚊哨哭恩唤啊唉罢峰圆贼贿钱钳钻铁铃铅缺氧特牺造乘敌秤租积秧秩称秘透笔笑笋债借值倚倾倒倘俱倡候俯倍倦健臭射躬息徒徐舰舱般航途拿爹爱颂翁脆脂胸胳脏胶脑狸狼逢留皱饿恋桨浆衰高席准座脊症病疾疼疲效离唐资凉站剖竞部旁旅畜阅羞瓶拳粉料益兼烤烘烦烧烛烟递涛浙涝酒涉消浩海涂浴浮流润浪浸涨烫涌悟悄悔悦害宽家宵宴宾窄容宰案请朗诸读扇袜袖袍被祥课谁调冤谅谈谊剥恳展剧屑弱陵陶陷陪娱娘通能难预桑绢绣验继球理捧堵描域掩捷排掉堆推掀授教掏掠培接控探据掘职基著勒黄萌萝菌菜萄菊萍菠营械梦梢梅检梳梯桶救副票戚爽聋袭盛雪辅辆虚雀堂常匙晨睁眯眼悬野啦晚啄距跃略蛇累唱患唯崖崭崇圈铜铲银甜梨犁移笨笼笛符第敏做袋悠偿偶偷您售停偏假得衔盘船斜盒鸽悉欲彩领脚脖脸脱象够猜猪猎猫猛馅馆凑减毫麻痒痕廊康庸鹿盗章竟商族旋望率着盖粘粗粒断剪兽清添淋淹渠渐混渔淘液淡深婆梁渗情惜惭悼惧惕惊惨惯寇寄宿窑密谋谎祸谜逮敢屠弹随蛋隆隐婚婶颈绩绪续骑绳维绵绸绿琴斑替款堪搭塔越趁趋超提堤博揭喜插揪搜煮援裁搁搂搅握揉斯期欺联散惹葬葛董葡敬葱落朝辜葵棒棋植森椅椒棵棍棉棚棕惠惑逼厨厦硬确雁殖裂雄暂雅辈悲紫辉敞赏掌晴暑最量喷晶喇遇喊景践跌跑遗蛙蛛蜓喝喂喘喉幅帽赌赔黑铸铺链销锁锄锅锈锋锐短智毯鹅剩稍程稀税筐等筑策筛筒答筋筝傲傅牌堡集焦傍储奥街惩御循艇舒番释禽腊脾腔鲁猾猴然馋装蛮就痛童阔善羡普粪尊道曾焰港湖渣湿温渴滑湾渡游滋溉愤慌惰愧愉慨割寒富窜窝窗遍裕裤裙谢谣谦属屡强粥疏隔隙絮嫂登缎缓编骗缘瑞魂肆摄摸填搏塌鼓摆携搬摇搞塘摊蒜勤鹊蓝墓幕蓬蓄蒙蒸献禁楚想槐榆楼概赖酬感碍碑碎碰碗碌雷零雾雹输督龄鉴睛睡睬鄙愚暖盟歇暗照跨跳跪路跟遣蛾蜂嗓置罪罩错锡锣锤锦键锯矮辞稠愁筹签简毁舅鼠催傻像躲微愈遥腰腥腹腾腿触解酱痰廉新韵意粮数煎塑慈煤煌满漠源滤滥滔溪溜滚滨粱滩慎誉塞谨福群殿辟障嫌嫁叠缝缠静碧璃墙撇嘉摧截誓境摘摔聚蔽慕暮蔑模榴榜榨歌遭酷酿酸磁愿需弊裳颗嗽蜻蜡蝇蜘赚锹锻舞稳算箩管僚鼻魄貌膜膊膀鲜疑馒裹敲豪膏遮腐瘦辣竭端旗精歉熄熔漆漂漫滴演漏慢寨赛察蜜谱嫩翠熊凳骡缩慧撕撒趣趟撑播撞撤增聪鞋蕉蔬横槽樱橡飘醋醉震霉瞒题暴瞎影踢踏踩踪蝶蝴嘱墨镇靠稻黎稿稼箱箭篇僵躺僻德艘膝膛熟摩颜毅糊遵潜潮懂额慰劈操燕薯薪薄颠橘整融醒餐嘴蹄器赠默镜赞篮邀衡膨雕磨凝辨辩糖糕燃澡激懒壁避缴戴擦鞠藏霜霞瞧蹈螺穗繁辫赢糟糠燥臂翼骤鞭覆蹦镰翻鹰警攀蹲颤瓣爆疆壤耀躁嚼嚷籍魔灌蠢霸露囊罐"
var CommonlyChineseCharacters_Sec:String = "匕刁丐歹戈夭仑讥冗邓艾夯凸卢叭叽皿凹囚矢乍尔冯玄邦迂邢芋芍吏夷吁吕吆屹廷迄臼仲伦伊肋旭匈凫妆亥汛讳讶讹讼诀弛阱驮驯纫玖玛韧抠扼汞扳抡坎坞抑拟抒芙芜苇芥芯芭杖杉巫杈甫匣轩卤肖吱吠呕呐吟呛吻吭邑囤吮岖牡佑佃伺囱肛肘甸狈鸠彤灸刨庇吝庐闰兑灼沐沛汰沥沦汹沧沪忱诅诈罕屁坠妓姊妒纬玫卦坷坯拓坪坤拄拧拂拙拇拗茉昔苛苫苟苞茁苔枉枢枚枫杭郁矾奈奄殴歧卓昙哎咕呵咙呻咒咆咖帕账贬贮氛秉岳侠侥侣侈卑刽刹肴觅忿瓮肮肪狞庞疟疙疚卒氓炬沽沮泣泞泌沼怔怯宠宛衩祈诡帚屉弧弥陋陌函姆虱叁绅驹绊绎契贰玷玲珊拭拷拱挟垢垛拯荆茸茬荚茵茴荞荠荤荧荔栈柑栅柠枷勃柬砂泵砚鸥轴韭虐昧盹咧昵昭盅勋哆咪哟幽钙钝钠钦钧钮毡氢秕俏俄俐侯徊衍胚胧胎狰饵峦奕咨飒闺闽籽娄烁炫洼柒涎洛恃恍恬恤宦诫诬祠诲屏屎逊陨姚娜蚤骇耘耙秦匿埂捂捍袁捌挫挚捣捅埃耿聂荸莽莱莉莹莺梆栖桦栓桅桩贾酌砸砰砾殉逞哮唠哺剔蚌蚜畔蚣蚪蚓哩圃鸯唁哼唆峭唧峻赂赃钾铆氨秫笆俺赁倔殷耸舀豺豹颁胯胰脐脓逛卿鸵鸳馁凌凄衷郭斋疹紊瓷羔烙浦涡涣涤涧涕涩悍悯窍诺诽袒谆祟恕娩骏琐麸琉琅措捺捶赦埠捻掐掂掖掷掸掺勘聊娶菱菲萎菩萤乾萧萨菇彬梗梧梭曹酝酗厢硅硕奢盔匾颅彪眶晤曼晦冕啡畦趾啃蛆蚯蛉蛀唬啰唾啤啥啸崎逻崔崩婴赊铐铛铝铡铣铭矫秸秽笙笤偎傀躯兜衅徘徙舶舷舵敛翎脯逸凰猖祭烹庶庵痊阎阐眷焊焕鸿涯淑淌淮淆渊淫淳淤淀涮涵惦悴惋寂窒谍谐裆袱祷谒谓谚尉堕隅婉颇绰绷综绽缀巢琳琢琼揍堰揩揽揖彭揣搀搓壹搔葫募蒋蒂韩棱椰焚椎棺榔椭粟棘酣酥硝硫颊雳翘凿棠晰鼎喳遏晾畴跋跛蛔蜒蛤鹃喻啼喧嵌赋赎赐锉锌甥掰氮氯黍筏牍粤逾腌腋腕猩猬惫敦痘痢痪竣翔奠遂焙滞湘渤渺溃溅湃愕惶寓窖窘雇谤犀隘媒媚婿缅缆缔缕骚瑟鹉瑰搪聘斟靴靶蓖蒿蒲蓉楔椿楷榄楞楣酪碘硼碉辐辑频睹睦瞄嗜嗦暇畸跷跺蜈蜗蜕蛹嗅嗡嗤署蜀幌锚锥锨锭锰稚颓筷魁衙腻腮腺鹏肄猿颖煞雏馍馏禀痹廓痴靖誊漓溢溯溶滓溺寞窥窟寝褂裸谬媳嫉缚缤剿赘熬赫蔫摹蔓蔗蔼熙蔚兢榛榕酵碟碴碱碳辕辖雌墅嘁踊蝉嘀幔镀舔熏箍箕箫舆僧孵瘩瘟彰粹漱漩漾慷寡寥谭褐褪隧嫡缨撵撩撮撬擒墩撰鞍蕊蕴樊樟橄敷豌醇磕磅碾憋嘶嘲嘹蝠蝎蝌蝗蝙嘿幢镊镐稽篓膘鲤鲫褒瘪瘤瘫凛澎潭潦澳潘澈澜澄憔懊憎翩褥谴鹤憨履嬉豫缭撼擂擅蕾薛薇擎翰噩橱橙瓢蟥霍霎辙冀踱蹂蟆螃螟噪鹦黔穆篡篷篙篱儒膳鲸瘾瘸糙燎濒憾懈窿缰壕藐檬檐檩檀礁磷瞭瞬瞳瞪曙蹋蟋蟀嚎赡镣魏簇儡徽爵朦臊鳄糜癌懦豁臀藕藤瞻嚣鳍癞瀑襟璧戳攒孽蘑藻鳖蹭蹬簸簿蟹靡癣羹鬓攘蠕巍鳞糯譬霹躏髓蘸镶瓤矗"
# Input content
var CurrentInputString: String = ""
var CurrentInputString_escaped: String = ""
var _current_cursor_pos: int = 0
# Page scroll
var _current_line: int = 0
# Input visual
var _flash: bool = false
var _flash_timer = Timer.new()
var _start_up:int = 0
var _just_enter: bool = false
var _PrefixText: String = ""
# History
var _send_history: Array[String] = []
var _current_history : int = -1
var _last_input: String = ""
# Edit mode
var current_file: String = ""
var current_file_type: String = "Text"
var _just_save: String = ""

@export var SetLocaleToEng: bool = false

func _ready() -> void:
	if SetLocaleToEng:
		TranslationServer.set_locale("en_US")
	size = Vector2(console_size.x * 12.5, console_size.y * 23)
	_built_in_command_init()
	add_child(_flash_timer)
	text = ""
	_flash_timer.set_one_shot(true)
	_flash_timer.start(1)
	
func _process(delta: float) -> void:
	set_prefix()
	if _flash_timer.time_left == 0:
		if _start_up == 0 and ShowTextArt:
			# Show Title: The art is 61*12, with border is 63*14
			for i in(console_size.y / 2 + 7):
				if i < console_size.y / 2 - 7:
					newline()
				else:
					push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
					if console_size.x >= 63:
						append_text(TextArt[i-console_size.y / 2 + 7])
					elif console_size.x >= 34:
						append_text(TextArtThin[i-console_size.y / 2 + 7])
					pop()
					newline()
			_start_up += 1
			_flash_timer.start()
		else:
			_flash = !_flash
			if !CanInput:
				clear()
				CanInput = true
			append_current_input_string()
			_flash_timer.start()
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_pressed() and CanInput:
		match event.as_text():
			# Main character
			"A","B","C","D","E","F","G",\
			"H","I","J","K","L","M","N",\
			"O","P","Q","R","S","T","U",\
			"V","W","X","Y","Z":
				insert_character(event.as_text().to_lower())
			"Shift+A","Shift+B","Shift+C","Shift+D","Shift+E","Shift+F","Shift+G",\
			"Shift+H","Shift+I","Shift+J","Shift+K","Shift+L","Shift+M","Shift+N",\
			"Shift+O","Shift+P","Shift+Q","Shift+R","Shift+S","Shift+T","Shift+U",\
			"Shift+V","Shift+W","Shift+X","Shift+Y","Shift+Z",\
			"Kp 1","Kp 2","Kp 3","Kp 4","Kp 5","Kp 6","Kp 7","Kp 8","Kp 9","Kp 0":
				insert_character(event.as_text()[-1])
			"0","1","2","3","4","5","6","7","8","9":
				insert_character(event.as_text())
			"Space","Shift_Space":	insert_character(" ")
			# BBCode
			"BracketLeft":		insert_character("[")
			"BracketRight":		insert_character("]")
			"Slash","Kp Divide":insert_character("/")
			# Other character
			"QuoteLeft":		insert_character("`")
			"Shift+QuoteLeft":	insert_character("~")
			"Shift+1":	insert_character("!")
			"Shift+2":	insert_character("@")
			"Shift+3":	insert_character("#")
			"Shift+4":	insert_character("$")
			"Shift+5":	insert_character("%")
			"Shift+6":	insert_character("^")
			"Shift+7":	insert_character("&")
			"Shift+8","Kp Multiply":	insert_character("*")
			"Shift+9":	insert_character("(")
			"Shift+0":	insert_character(")")
			"Minus","Kp Subtract":	insert_character("-")
			"Shift+Minus":			insert_character("_")
			"Equal":				insert_character("=")
			"Shift+Equal","Kp Add":	insert_character("+")
			"Shift+BracketLeft":	insert_character("{")
			"Shift+BracketRight":	insert_character("}")
			"BackSlash":			insert_character("\\")
			"Shift+BackSlash":		insert_character("|")
			"Semicolon":			insert_character(";")
			"Shift+Semicolon":		insert_character(":")
			"Apostrophe":			insert_character("'")
			"Shift+Apostrophe":		insert_character("\"")
			"Comma":				insert_character(",")
			"Shift+Comma":			insert_character("<")
			"Period","Kp Period":	insert_character(".")
			"Shift+Period":			insert_character(">")
			"Shift+Slash":			insert_character("?")
			# Special action
			"Shift":
				pass
			"Backspace","Shift+Backspace":
				scroll_to_line(get_line_count())
				_current_line = 0
				if _current_cursor_pos == 0:
					if CurrentInputString.right(1) == "\n":
						remove_paragraph(get_paragraph_count()-1)
					CurrentInputString = CurrentInputString.left(CurrentInputString.length()-1)
				elif _current_cursor_pos > 0 && _current_cursor_pos < CurrentInputString.length():
					if CurrentInputString[CurrentInputString.length() -_current_cursor_pos - 1] == "\n":
						remove_paragraph(get_paragraph_count()-1)
					CurrentInputString = CurrentInputString.erase(CurrentInputString.length() -_current_cursor_pos - 1)
			"Enter","Kp Enter":
				match CurrentMode:
					"","Default":
						append_current_input_string(true)
					"Edit":
						append_text("[p][/p]")
						insert_character("\n")
			"Left":
				scroll_to_line(get_line_count())
				_current_line = 0
				_flash = true
				if _current_cursor_pos < CurrentInputString.length():
					_current_cursor_pos += 1
			"Right":
				scroll_to_line(get_line_count())
				_current_line = 0
				_flash = true
				if _current_cursor_pos > 0:
					_current_cursor_pos -= 1
			"Up":
				if CurrentMode == "" or CurrentMode == "Default":
					append_history()
			"Down":
				if CurrentMode == "" or CurrentMode == "Default":
					append_history(false)
			"PageUp":
				scroll_page(false)
			"PageDown":
				scroll_page()
			# File edit
			"Ctrl+S":
				if CurrentMode == "Edit":
					_flash = true
					if match_file_type(current_file_type,CurrentInputString):
						match_file_type(current_file_type,CurrentInputString,false,true)
						_just_save = "Success"
					else:
						_just_save = "Fail"
			"Ctrl+X":
				if CurrentMode == "Edit":
					_flash = false
					_current_cursor_pos = 0
					append_current_input_string()
					newline()
					CurrentMode = ""
					CurrentInputString = ""
					set_prefix()
				
			# Unpacthed
			_: print(event.as_text())
		CurrentInputString_escaped = CurrentInputString.replace("[", "[lb]").replace("\n", "\u2B92\n")
		append_current_input_string()
		_just_enter = false

func append_current_input_string(enter:bool=false) -> void:
	if !_just_enter:
		remove_paragraph(get_paragraph_count()-1)
		match CurrentMode:
			"Edit":
				for i in CurrentInputString.count("\n"):
					remove_paragraph(get_paragraph_count()-1)
			
	if !enter:
		if _flash:
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			if _current_cursor_pos == 0:
				match _just_save:
					"Success":
						append_text(_PrefixText + CurrentInputString_escaped + "[color=LIME_GREEN]\u2581[/color]")
					"Fail":
						append_text(_PrefixText + CurrentInputString_escaped + "[color=CRIMSON]\u2581[/color]")
					_:
						append_text(_PrefixText + CurrentInputString_escaped + "\u2581")
			elif _current_cursor_pos > 0:
				var minus_num = (3 * CurrentInputString.right(_current_cursor_pos - 1).count("["))\
						+ (CurrentInputString.right(_current_cursor_pos - 1).count("\n"))
				var cis_left: String = _PrefixText + CurrentInputString_escaped.left(-_current_cursor_pos - minus_num)
				match CurrentInputString[-_current_cursor_pos]:
					"[":
						append_text(cis_left.trim_suffix("[lb"))
					"\n":
						append_text(cis_left.trim_suffix("\u2B92"))
					_:
						append_text(cis_left)
				match _just_save:
					"Success":
						push_bgcolor(Color("LIME_GREEN"))
					"Fail":
						push_bgcolor(Color("CRIMSON"))
					_:
						push_bgcolor(Color("WHITE"))
				push_color(Color("BLACK"))
				match CurrentInputString[-_current_cursor_pos]:
					"[":
						append_text("[")
					"\n":
						append_text("\u2B92\n")
					_:
						append_text(CurrentInputString_escaped[-_current_cursor_pos - minus_num])
				pop()
				pop()
				append_text(CurrentInputString_escaped.right(_current_cursor_pos - 1 + minus_num))
				if CurrentMode == "Edit":
					append_text(" ")
			pop()
		else:
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			append_text(_PrefixText + CurrentInputString_escaped + " ")
			pop()
	else:
		_current_cursor_pos = 0
		push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		append_text(_PrefixText + CurrentInputString_escaped)
		pop()
		newline()
		if CurrentInputString != "":
			_send_history.append(CurrentInputString)
		_current_history = -1
		_last_input = ""
		process(CurrentInputString)
		if current_path == "":
			current_path = "/"
		set_prefix()
		if CurrentMode == "" or CurrentMode == "Default":
			CurrentInputString = ""
			CurrentInputString_escaped = ""
		_just_enter = true
		scroll_to_line(get_line_count())
		_current_line = 0

func insert_character(character:String) -> void:
	scroll_to_line(get_line_count())
	_just_save = ""
	_current_line = 0
	if _current_cursor_pos == 0:
		CurrentInputString += character
	elif _current_cursor_pos > 0:
		CurrentInputString = CurrentInputString.insert(CurrentInputString.length() -_current_cursor_pos,character)

func scroll_page(down:bool = true) -> void:
	if down:
		if _current_line > 0:
			_current_line -= 1
	elif _current_line < get_line_count() - console_size.y:
		_current_line += 1
	scroll_to_line(get_line_count() - console_size.y - _current_line)

func append_history(up:bool = true) -> void:
	scroll_to_line(get_line_count())
	_current_cursor_pos = 0
	if _current_history == -1:
		_last_input = CurrentInputString
	if _send_history.size() != 0:
		if up:
			if _current_history == -1:
				_current_history = _send_history.size() -1
			elif _current_history != 0:
				_current_history -= 1
		else:
			if _current_history == -1:
				pass
			elif _current_history == _send_history.size() -1:
				_current_history = -1
			elif _current_history < _send_history.size() -1:
				_current_history += 1
	if _send_history.size() != 0 and _current_history != -1 and _current_history <= _send_history.size() -1:
		CurrentInputString = _send_history[_current_history]
	else:
		_current_history = -1
		CurrentInputString = _last_input
		
func set_prefix() -> void:
	match CurrentMode:
		"","Default":
			_PrefixText = "[bgcolor=DODGER_BLUE]" + USER_Name + "[/bgcolor][bgcolor=WEB_GRAY][color=DODGER_BLUE]\u25E3[/color]"\
				+ return_path_string(current_path) +"[/bgcolor][color=WEB_GRAY]\u25B6[/color]"
		"Edit":
			_PrefixText = "[bgcolor=DODGER_BLUE]" + USER_Name + "[/bgcolor][bgcolor=WEB_GRAY][color=DODGER_BLUE]\u25E3[/color]"\
				+ return_path_string(current_path) +"[/bgcolor][bgcolor=BURLYWOOD][color=WEB_GRAY]\u25B6[/color]"\
				+ "\U01F4DD" + current_file + "[/bgcolor][color=BURLYWOOD]\u25B6[/color]"
		_:
			append_text(tr("error.mode_undefined"))
			CurrentMode = ""

func process(command):
	command = command.replace("\\,", "[comma]")
	command = command.replace("\\(", "[lp]")
	command = command.replace("\\)", "[rp]")
	if !commands.keys().has(command.get_slice("(",0)):
		push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		append_text("[color=RED]" + tr("error.command_not_found") + "[/color] " + command.get_slice("(",0))
		pop()
		newline()
	else:
		var commandData = commands[command.get_slice("(",0)]
		var argu_in:Array[String] = []
		var argu_in_unesc:Array[String] = []
		if command.contains("("):
			argu_in.append_array(command.trim_prefix(command.get_slice("(",0)+"(").trim_suffix(")").split(","))
			for i in argu_in:
				i=i.replace("[comma]", ",")
				i=i.replace("[lp]", "(")
				i=i.replace("[rp]", ")")
				argu_in_unesc.append(i)
		if commandData.function.get_argument_count() != argu_in.size():
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			append_text("[color=RED]" + tr("error.parameter_count_mismatch") + "[/color] " + tr("error.parameter_count_mismatch.expect_got") \
							% [str(commandData.function.get_argument_count()),argu_in_unesc])
			pop()
		else:
			commandData.function.callv(argu_in_unesc)
	
func add_command(id:String, function:Callable, functionInstance:Object, helpText:String="", helpDetail:String = ""):
	commands[id] = EC_CommandClass.new(id, function, functionInstance, helpText, helpDetail)

func _built_in_command_init():
	add_command(
		"help", 
		func(id:String):
			if id == "":
				for i in commands:
					append_text("<"+i+"> "+commands[i].helpText)
					pop_all()
					newline()
				return
			elif commands.keys().has(id):
				append_text(commands[id].helpDetail)
			else:
				append_text("[color=RED]" + tr("error.command_not_found") + "[/color] " + id)
			pop_all()
			newline(),
		self,
		tr("help.help"),
		tr("help.help.detail")
	)
	add_command(
		"clear", 
		func():
			clear()
			return,
		self,
		tr("help.clear"),
		tr("help.clear.detail")
	)
	add_command(
		"echo", 
		func(input:String):
			append_text(input)
			pop_all(),
		self,
		tr("help.echo"),
		tr("help.echo.detail")
	)
	
	# File system
	add_command(
		"currentDir",
		func():
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				append_text(current_path)
			else:
				append_text(path_instance.get(null))
				current_path = "/home"
			pop_all(),
		self,
		tr("help.current_dir"),
		tr("help.current_dir.detail")
	)
	add_command(
		"dir",
		func():
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				for i in path_instance:
					var icon = "\uFFFD"
					if path_instance[i] == null:
						icon = "\u2613"
					elif path_instance[i] is String:
						if path_instance[i] != "":
							icon = "\U01F5CE"
						else:
							icon = "\U01F5CB"
					elif path_instance[i] is Dictionary:
						if path_instance[i].is_empty():
							icon = "\U01F4C2"
						else:
							icon = "\U01F5C1"
					elif path_instance[i] is bool:
						if path_instance[i]:
							icon = "\u2705"
						else:
							icon = "\u274E"
					elif path_instance[i] is int or path_instance[i] is float:
						if path_instance[i] == 0:
							icon = "\U01F5D2"
						else:
							icon = "\U01F5D3"
					elif path_instance[i] is StringName:
						icon = "\U01F524"
					elif path_instance[i] is NodePath:
						icon = "\U01F517"
					elif path_instance[i] is Object:
						match path_instance[i].get_class():
							"GDScript":
								icon = "\U01F4C3"
							_:
								icon = "\U01F4E6"
					elif path_instance[i] is Array:
						icon = "\U01F4DA"
					elif path_instance[i] is PackedByteArray\
					or path_instance[i] is PackedInt32Array\
					or path_instance[i] is PackedInt64Array\
					or path_instance[i] is PackedFloat32Array\
					or path_instance[i] is PackedFloat64Array:
						if path_instance[i].is_empty():
							icon = "\U01F5C7"
						else:
							icon = "\U01F5CA"
					elif path_instance[i] is PackedStringArray:
						if path_instance[i].is_empty():
							icon = "\U01F5CD"
						else:
							icon = "\U01F5D0"
					if i is String:
						if i.is_valid_filename():
							append_text(icon + i)
						else:
							append_text("[color=RED]" + icon + i + "[/color]")
					elif i is StringName:
						print("yes")
					else:
						append_text("[color=RED]" + icon + str(i) + "[/color]")
					pop_all()
					newline()
			else:
				append_text(path_instance.get(null))
				current_path = "/home"
			pop_all(),
		self,
		tr("help.dir"),
		tr("help.dir.detail")
	)
	add_command(
		"changeDir",
		func(path:String):
			if !get_path_instance(path,true).has(null):
				pass
			else:
				append_text(get_path_instance(path).get(null))
			pop_all(),
		self,
		tr("help.change_dir"),
		tr("help.change_dir.detail")
	)
	add_command(
		"makeDir",
		func(folder_name:String):
			if folder_name.is_valid_filename():
				var path_instance = get_path_instance(current_path)
				if !path_instance.has(null):
					if !path_instance.has(folder_name):
						path_instance.get_or_add(folder_name,{})
					else:
						append_text("[i]" + folder_name + "[/i] " + tr("error.already_exist"))
				else:
					append_text(path_instance.get(null))
			else:
				append_text("[color=RED]" + tr("error.invalid_file_name") + "[/color] [i]" + folder_name + "[/i]" + tr("error.invalid_file_name.hint") + " [b]:/\\?*|%<>[/b]")
			pop_all(),
		self,
		tr("help.make_dir"),
		tr("help.make_dir.detail")
	)
	add_command(
		"makeFile",
		func(file_name:String,type:String,content:String):
			if file_name.is_valid_filename():
				var path_instance = get_path_instance(current_path)
				if !path_instance.has(null):
					if !path_instance.has(file_name):
						path_instance.get_or_add(file_name,"")
						match_file_type(type,content,true,true,path_instance,file_name)
					else:
						append_text("[i]" + file_name + "[/i] " + tr("error.already_exist"))
				else:
					append_text(path_instance.get(null))
			else:
				append_text("[color=RED]" + tr("error.invalid_file_name") + "[/color] [i]" + file_name + "[/i]" + tr("error.invalid_file_name.hint") + " [b]:/\\?*|%<>[/b]")
			pop_all(),
		self,
		tr("help.make_file"),
		tr("help.make_file.detail")
	)
	add_command(
		"remove",
		func(file_name:String):
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					path_instance.erase(file_name)
				else:
					append_text("[i]" + file_name + "[/i] " + tr("error.not_exist"))
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		tr("help.remove"),
		tr("help.remove.detail")
	)
	add_command(
		"rename",
		func(file_name:String,to_name:String):
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if to_name.is_valid_filename():
						if !path_instance.has(to_name):
							path_instance.get_or_add(to_name,path_instance.get(file_name).duplicate(true))
							path_instance.erase(file_name)
						else:
							append_text("[i]" + to_name + "[/i] " + tr("error.already_exist"))
					else:
						append_text("[color=RED]" + tr("error.invalid_file_name") + "[/color][i]" + to_name + "[/i]" + tr("error.invalid_file_name.hint") + " [b]:/\\?*|%<>[/b]")
				else:
					append_text("[i]" + file_name + "[/i] " + tr("error.not_exist"))
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		tr("help.rename"),
		tr("help.remane.detail")
	)
	add_command(
		"copy",
		func(file_name:String,to_path:String,to_name:String):
			var path_instance = get_path_instance(current_path)
			var result_path_instance = get_path_instance(to_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if !result_path_instance.has(null):
						if to_name == "":
							to_name = file_name
						if to_name.is_valid_filename():
							if !result_path_instance.has(to_name):
								result_path_instance.get_or_add(to_name,path_instance.get(file_name).duplicate(true))
							else:
								append_text("[i]" + to_name + "[/i] " + tr("error.already_exist"))
						else:
							append_text("[color=RED]" + tr("error.invalid_file_name") + "[/color][i]" + to_name + "[/i]" + tr("error.invalid_file_name.hint") + " [b]:/\\?*|%<>[/b]")
					else:
						append_text(result_path_instance.get(null))
				else:
					append_text("[i]" + file_name + "[/i] " + tr("error.not_exist"))
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		tr("help.copy"),
		tr("help.copy.detail")
	)
	add_command(
		"move",
		func(file_name:String,to_path:String):
			var path_instance = get_path_instance(current_path)
			var result_path_instance = get_path_instance(to_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if !result_path_instance.has(null):
						if !result_path_instance.has(file_name):
							result_path_instance.get_or_add(file_name,path_instance.get(file_name).duplicate(true))
							path_instance.erase(file_name)
						else:
							append_text("[i]" + file_name + "[/i] " + tr("error.already_exist"))
					else:
						append_text(result_path_instance.get(null))
				else:
					append_text("[i]" + file_name + "[/i] " + tr("error.not_exist"))
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		tr("help.move"),
		tr("help.move.detail")
	)
	add_command(
		"read",
		func(file_name:String):
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					append_text(str(path_instance[file_name]))
				else:
					append_text("[i]" + file_name + "[/i] " + tr("error.not_exist"))
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		tr("help.read"),
		tr("help.read.detail")
	)
	add_command(
		"edit",
		func(file_name:String):
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if path_instance[file_name] is String:
						current_file_type = "Text"
					elif path_instance[file_name] is int or path_instance[file_name] is float:
						current_file_type = "Number"
					elif path_instance[file_name] is bool:
						current_file_type = "Boolean"
					else:
						append_text(tr("error.cant_edit"))
						pop_all()
						return
					CurrentMode = "Edit"
					current_file = file_name
					CurrentInputString = str(path_instance[file_name])
				else:
					append_text("[i]" + file_name + "[/i] " + tr("error.not_exist"))
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		tr("help.edit"),
		tr("help.edit.detail")
	)
	
	# Character Test
	add_command(
		"characterTest", 
		func(test_list:String):
			var SortArray: Array[String] = []
			match test_list:
				"chinese0":
					for i in CommonlyChineseCharacters:
						SortArray.append(i)
				"chinese1":
					for i in CommonlyChineseCharacters_Sec:
						SortArray.append(i)
				_:
					append_text("List does not exist.")
					pop_all()
			SortArray.sort()
			var result: String = ""
			for i in SortArray:
				result += i
			append_text(result)
			pop_all(),
		self,
		tr("help.character_test"),
		tr("help.character_test.detail")
	)
	
	add_command(
		"parse", 
		func(command:String):
			var expression = Expression.new()
			var error = expression.parse(command)
			if error != OK:
				append_text("[color=RED]" + tr("error.parse") + "[/color] " + expression.get_error_text())
				pop_all()
			else:
				var result = expression.execute()
				if not expression.has_execute_failed() and result:
					append_text(str(result))
					pop_all(),
		self,
		tr("help.parse"),
		tr("help.parse.detail")
	)

func return_path_string(path:String) -> String:
	if current_path == "/home":
		return "\u2302"
	else:
		return current_path

func get_path_instance(path:String,goto:bool=false) -> Dictionary:
	if !path.begins_with("/"):
		path = current_path + "/" + path
	var current_path_instance = fileDirectory
	var path_array:PackedStringArray = path.split("/")
	if path_array.has(".."):
		while path_array.find("..") != -1:
			path_array.remove_at(path_array.find("..") - 1)
			path_array.remove_at(path_array.find(".."))
	for i in path_array:
		if i != "":
			if !current_path_instance.has(i):
				return {null:"[i]" + path + "[/i] " + tr("error.not_exist")}
			elif current_path_instance.get(i) is Dictionary:
				current_path_instance = current_path_instance[i]
			else:
				return {null:"[i]" + path + "[/i] " + tr("error.not_valid_directory")}
	if goto:
		current_path = ""
		for i in path_array:
			if i != "" and i != ".":
				current_path += "/" + i
	return current_path_instance

func match_file_type(type:String="Text",content:String="",append_error:bool=false,apply:bool=false,path:Dictionary=get_path_instance(current_path),file:String=current_file) -> bool:
	match type:
		"","Text":
			if content != "":
				if apply:
					path[file] = content
				return true
			else:
				if apply:
					path[file] = ""
				return false
		"Number":
			if content != "":
				if content.is_valid_int():
					if apply:
						path[file] = int(content)
					return true
				elif content.is_valid_float():
					if apply:
						path[file] = float(content)
					return true
				else:
					if append_error:
						append_text("[color=RED]" + tr("error.parameter_type_mismatch") + "[/color] " + tr("error.parameter_type_mismatch.expect_got") \
							% [tr("error.type.number"),content,"[i]0[/i]"])
					if apply:
						path[file] = 0
				return false
			else:
				if apply:
					path[file] = 0
				return false
		"Boolean":
			if content != "":
				if content == "true":
					if apply:
						path[file] = true
					return true
				elif content == "false":
					if apply:
						path[file] = false
					return true
				else:
					if append_error:
						append_text("[color=RED]" + tr("error.parameter_type_mismatch") + "[/color] " + tr("error.parameter_type_mismatch.expect_got") \
							% [tr("error.type.boolean"),content,"[i]false[/i]"])
					if apply:
						path[file] = false
					return false
			else:
				if apply:
					path[file] = false
				return false
		_:
			if append_error:
				append_text(tr("error.unknown_file_type") % [type])
			return false
