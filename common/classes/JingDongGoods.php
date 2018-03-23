<?php
namespace common\classes;
/**
 * 京东商品相关API接口 接口调用说明结合京东api
 * Created by PhpStorm.
 * User: pzh
 * Date: 2017/10/9
 * Time: 13:45
 */
class JingDongGoods extends JingDongBase {

    protected static $_instance = null;

    protected function __construct() {
        //disallow new instance
        parent::__construct();
    }

    protected function __clone() {
        //disallow clone
    }

    public static function getInstance() {
        if(self::$_instance === null) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    /**
     * 查询商品池编号
     * @return  mixed   List<ProductPoolVO>
         name	        String	    池子名称
         page_num	    String	    池子编号
     */
    public function getProductPools() {
        $method = "biz.product.PageNum.query";
        $resultArray = $this->requestApi($method);
        return $resultArray;
    }

    /**
     * 根据区商品池编号，获取池内商品编号
     *   pageNum         String      商品池编号
     * @return mixed    String
        商品skuid，多类型，以【，】拼接
     */
    public function getSkusWithPageNum($postData) {
        $method = "biz.product.sku.query";

        // 业务参数可传键
        $paramKeys = array("pageNum");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 获取池内商品编号接口-品类商品池（兼容老接口）
     * 从api的说明看,这边的分页无意义，因为没有设置页面大小的参数,而且文档中存在功能相同的接口，此接口先封装好，有需要再用
     * @param       String      pageNum     商品池编号
     * @param       int         pageNo      页码
     * @return mixed
         pageCount      int         总页数
         skuIds         array       sku
     */
    public function getSkusWithPageNumCategory($postData) {
        $method = "jd.biz.product.getSkuByPage";

        // 业务参数可传键
        $paramKeys = array("pageNum", "pageNo");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
     }

    /**
     * 获取池内商品编号接口-品类商品池（兼容老接口）
     * 生产环境按需使用 非必要可以不递归
     * @param       pageNum         商品池编号
     * @param       pageNo          页码
     * @param       productLists    sku对象集合
     * @param       pageCount       总页数
     * @return array sku对象集合
     */
    public function getAllSkuByPageNumAndPageNo($postData) {
        $postData['pageNo'] = (isset($postData['pageNo']) && intval($postData['pageNo']) != 0) ? intval($postData['pageNo']) : 1;
        $postData['pageCount'] = (isset($postData['pageCount']) && intval($postData['pageCount']) != 1) ? intval($postData['pageCount']) : 1;
        $postData['productLists'] = empty($postData['productLists']) ? array() : $postData['productLists'];

        if($postData['pageCount'] < $postData['pageNo']) {
           return $postData['productLists'];
        }

        $result = $this->getSkusWithPageNumCategory($postData);

        $skuIdsLists = $result['skuIds'];
        $countSkuIds = count($skuIdsLists);
        for($i = 0; $i < $countSkuIds; $i ++) {
            $postData['productLists'][] = $skuIdsLists[$i];
        }

        $postData['pageCount'] = $result['pageCount'];
        $postData['pageNo']++;
        return $this->getAllSkuByPageNumAndPageNo($postData);
    }

    /**
     * 根据商品编号，获取商品明细信息
     * @param       sku         商品编号，只支持单个查询
     * @return      mixed       返回结果会根据skuid位数而不同。sku不为8位会返回其他sku的格式，sku为8位时，返回图书或者是音像的详情结果。
     */
    public function getProductDetail($postData) {
        $method = "biz.product.detail.query";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 根据商品编号，获取商品详情的PC端样式
     * @param       sku         商品编号，只支持单个查询
     * @return      mixed       返回结果会根据skuid位数而不同。sku不为8位会返回其他sku的格式，sku为8位时，返回图书或者是音像的详情结果。
     */
    public function getPCStyle($postData) {
        $method = "jd.kpl.open.item.getwarestyleandjsbywareid";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 根据商品编号，获取商品详情的移动端样式
     * @param       sku         商品编号，只支持单个查询
     * @return      mixed       返回结果会根据skuid位数而不同。sku不为8位会返回其他sku的格式，sku为8位时，返回图书或者是音像的详情结果。
     */
    public function getMobileStyle($postData) {
        $method = "jd.kpl.open.item.getmobilewarestyleandjsbywareid";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 根据商品编号，获取商品上下架状态
     * @param       string      sku     商品编号，支持批量，以【，】分割，最高100个
     * @return mixed List<SkuStateVO>
         Sku        Long	    商品编号
         state      Integer     1：上架 0：下架
     */
    public function getProductShelvesState($postData) {
        $method = "biz.product.state.query";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 根据商品编号，获取图片信息
     * @param       String      sku     商品编号，支持批量，以【，】分割（最高支持100个）
     * @return mixed
     */
    public function getProductAllImages($postData) {
        $method = "biz.product.skuImage.query";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 根据商品编号，获取商品评价数据
     * @param       sku         string      商品编号，支持批量，以【，】分割（最高支持50个）
     * @return mixed List<CommentSummarysVO>
         averageScore	    BigDecimal	        商品评分 (5颗星，4颗星)
         goodRate	        BigDecimal	        好评度
         generalRate	    BigDecimal	        中评度
         poorRate	        BigDecimal	        差评度
         skuId	            Long	            商品编号
     */
    public function getProductPraiseRate($postData) {
        $method = "biz.product.commentSummarys.query";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 查看商品在选定地点是否可以购买
     * @param       string          skuIds          商品编号，支持批量，以【，】分割（最高支持50个）
     * @param       Integer         province        京东一级地址编号
     * @param       Integer         city            京东二级地址编号
     * @param       Integer         county          京东三级地址编号
     * @param       Integer         town            京东四级地址编号
     * @return mixed    List<CheckAreaLimitVO>
         skuId	            Long	    商品编号
         isAreaRestrict	    Boolean	    True 区域限制 false 不受区域限制
     */
    public function getProductRegionPurchaseLimit($postData) {
        $method = "biz.product.checkAreaLimit.query";

        // 业务参数可传键
        $paramKeys = array("skuIds", "province", "city", "county", "town");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 根据商品在选定地点是否支持货到付款
     * @param       string          skuIds          商品编号，支持批量，以【，】分割（最高支持50个）
     * @param       Integer         province        京东一级地址编号
     * @param       Integer         city            京东二级地址编号
     * @param       Integer         county          京东三级地址编号
     * @param       Integer         town            京东四级地址编号
     * @return mixed
        resultCode	Int	错误码：
            PARAM_NOT_NULL：参数不能为空
            PARAM_VALUE_ERROR：入参非法(sku不在商品池、查询sku数量超过指定数量50个、格式有误等)
            BIG_NOT_COD：大家电商品不支持货到付款
            SKU_HUODAOFUKUAN_UNSUPPORT：商品不支持货到付款（如奢侈品商品、厂家直送商品）
            NOT_COD_ORDER：地址不支持货到付款
            EXCEPTION:其他异常错误码
        result	Boolean	若验证所有商品都支持货到付款，则返回true;除此之外返回false
     */
    public function productIsSupportCashOnDelivery($postData) {
        $method = "biz.product.isCod.query";

        // 业务参数可传键
        $paramKeys = array("skuIds", "province", "city", "county", "town");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 查询赠品信息接口
     * @param       skuId           商品编号，只支持单个查询
     * @param       province        京东一级地址编号
     * @param       city            京东二级地址编号
     * @param       county          京东三级地址编号
     * @param       town            京东四级地址编号，存在四级地址必填，若不存在，则填0
     * @return mixed
     */
    public function getProductGift($postData) {
        $method = "biz.product.isCod.query";

        // 业务参数可传键
        $paramKeys = array("skuId", "province", "city", "county", "town");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 运费查询接口
     * @param       String      token               授权时获取的access token
     * @param       Array       sku                 [{“skuId”:商品编号1,”num”:商品数量1},{“skuId”:商品编号2,”num”:商品数量2}] （最多支持50种商品）
     * @param       int         province            一级地址
     * @param       int         city                二级地址
     * @param       int         county              三级地址
     * @param       int         town                四级地址(如果该地区有四级地址，则必须传递四级地址，没有四级地址则传0)                非必须
     * @param       int         paymentType         京东支付方式
     * @return mixed
         freight	            bigdecimal   	总运费
         baseFreight	        bigdecimal   	基础运费
         remoteRegionFreight	bigdecimal   	偏远运费
         remoteSku	            string	        需收取偏远运费的sku
     */
    public function getProductFreight($postData) {
        $method = "biz.order.freight.get";

        $jingDongAuthorize = JingDongAuthorize::getInstance();
        $token = $jingDongAuthorize->getToken();

        // 业务参数可传键
        $paramKeys = array("token", "sku", "province", "city", "county", "town", "paymentType");

        // 拼接业务参数
        $postData['token'] = $token;
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 商品可售验证接口
     * @param   string  skuIds      商品编号，支持批量，以，分隔  (最高支持100个商品)
     * @return mixed
         skuId	        Long	        商品编号
         name	        String	        商品名称
         saleState	    Int	            是否可售，1：是，0：否
         isCanVAT	    Int	            是否可开增票，1：支持，0：不支持
         is7ToReturn	Int	            是否支持7天退货，1：是，0：不支持
     */
    public function isProductCanSale($postData) {
        $method = "biz.product.sku.check";

        // 业务参数可传键
        $paramKeys = array("skuIds");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 下单预约日历接口
     * @param       int         province        京东省地址编号
     * @param       int         city            京东市地址编号
     * @param       int         county          京东县地址编号
     * @param       int         town            京东镇地址编号，与下单地址一致
     * @param       int         paymentType     支付方式，与下单一致
     * @param       sku         Array           [{"skuId":405075,"num":1},{"skuId":1311928,"num":1}] ,购买商品sku和数量的json字符串，与下单一致
     * @return mixed
     */
    public function getJdReservationCalendar($postData) {
        $method = "biz.order.promise.calendar.get";

        // 业务参数可传键
        $paramKeys = array("province", "city", "county", "town", "paymentType", "sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 查询商品延保接口  此接口的API系统参数与其他的接口有区别
     * @param       string      skuIds          商品编号，多个用英文逗号隔开
     * @param       int         province        京东省地址编号，必需大于0
     * @param       int         city            京东市地址编号，不区分市可给0
     * @param       int         county          京东县地址编号，可以给0
     * @param       int         town            京东镇地址编号，可以给0
     * @return mixed
     */
    public function getProductExtendedWarranty($postData) {
        $method = "biz.product.yanbao.sku.query";

        // 系统参数
        $jingDongAuthorize = JingDongAuthorize::getInstance();
        $accessToken = $jingDongAuthorize->getToken();

        $time = date("Y-m-d H:m:s", time());
        $systemParams = array(
            'method' => $method,
            'app_key' => $this->appKey,
            'access_token' => $accessToken,
            'timestamp' => $time,
            'format' => "json",
            'v' => "2.0",
            'sign_method' => "md5", // 签名的摘要算法，可选值为：hmac，md5
            'sign' => md5($postData['skuIds'] . $postData['province'] . $postData['city'] . $postData['county'] . $postData['town']), // API输入参数签名结果。
        );
        $url = $this->apiUrl . "?" . http_build_query($systemParams);

        // 业务参数可传键
        $paramKeys = array("skuIds", "province", "city", "county", "town");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray, $url);
        return $resultArray;
    }

    /**
     * 查询分类信息
     * @param       cid     分类id（可通过商品详情接口查询）
     * @return mixed
     */
    public function getCategoryDetail($postData) {
        $method = "jd.biz.product.getcategory";

        // 业务参数可传键
        $paramKeys = array("cid");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 查询分类列表信息(接口没有返回总页数)
     * @param       Integer         pageNo          页号，从1开始
     * @param       Integer         pageSize        页大小，最大值5000
     * @param       Integer         parentId        父ID                                     非必须
     * @param       Integer         catClass        分类等级（0:一级； 1:二级；2：三级）       非必须
     * @return mixed
     */
    public function getCategoryList($postData) {
        $method = "jd.biz.product.getcategorys";

        // 业务参数可传键
        $paramKeys = array("pageNo", "pageSize", "parentId", "catClass");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     *  按照关键字、价格、分类、品牌等实现商品搜索
     * @param       String          keyword             搜索关键字，需要编码
     * @param       String          catId               分类Id,只支持三级类目Id
     * @param       int             pageIndex           当前第几页
     * @param       int             pageSize            当前页显示
     * @param       String          min                 价格区间搜索，低价
     * @param       String          max                 价格区间搜索，高价
     * @param       String          brands              品牌搜索 多个品牌以逗号分隔，需要编码
     * @return mixed
     */
    public function searchProduct($postData) {
        $method = "jd.biz.search.search";

        // 业务参数可传键
        $paramKeys = array("keyword", "catId", "pageIndex", "pageSize", "min", "max", "brands");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 按照关键字、价格、分类、品牌等实现商品搜索
     * 生产环境按需使用，直接调用上面的搜索接口即可，非必要可以不递归
     * @param       String          keyword             搜索关键字，需要编码
     * @param       String          catId               分类Id,只支持三级类目Id
     * @param       int             pageIndex           当前第几页
     * @param       int             pageSize            当前页显示
     * @param       String          min                 价格区间搜索，低价
     * @param       String          max                 价格区间搜索，高价
     * @param       String          brands              品牌搜索 多个品牌以逗号分隔，需要编码
     * @param       int             pageCount           总页数
     * @param       array           productLists        结果集
     * @param       int             pageSize            页面大小
     * @return array
     */
    public function getAllSearchProductByConditionAndPageNo($postData) {
        $postData['pageIndex'] = (isset($postData['pageIndex']) && intval($postData['pageIndex']) != 0) ? intval($postData['pageIndex']) : 1;
        $postData['pageSize'] = (isset($postData['pageSize']) && intval($postData['pageSize']) != 0) ? intval($postData['pageSize']) : 100;
        $postData['productLists'] = empty($postData['productLists']) ? array() : $postData['productLists'];
        $postData['pageCount'] = (isset($postData['pageCount']) && intval($postData['pageCount']) != 0) ? intval($postData['pageCount']) : 1;

        if($postData['pageCount'] < $postData['pageIndex']) {
            return $postData['productLists'];
        }

        $result = $this->searchProduct($postData);
        $hitResultLists = $result['hitResult'];

        $productCounts = count($hitResultLists);
        for($i = 0; $i < $productCounts; $i ++) {
            $postData['productLists'][] = $hitResultLists[$i];
        }
        $postData['pageIndex']++;
        $postData['pageCount'] = $result['pageCount'];
        return $this->getAllSearchProductByConditionAndPageNo($postData);
    }

    /**
     * 同类商品查询
     * @param       skuId       商品编号,单个
     * @return mixed
     */
    public function getSimilarProducts($postData) {
        $method = "jd.biz.product.getSimilarSku";

        // 业务参数可传键
        $paramKeys = array("skuId");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 批量查询价格
     * @param       string      sku     商品编号，请以，分割。例如：J_129408,J_129409(最高支持100个商品)
     * @return mixed
     * skuId	    Long	        商品ID
     * jdPrice	    BigDecimal	    商品京东价格
     * Price	    BigDecimal	    商品协议价格
     */
    public function getProductsPrice($postData) {
        $method = "biz.price.sellPrice.get";

        // 业务参数可传键
        $paramKeys = array("sku");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 获取京东一级地址 省级别信息
     * @return mixed
     */
    public function getProvincesAddress() {
        $method = "biz.address.allProvinces.query";
        $resultArray = $this->requestApi($method);
        return $resultArray;
    }

    /**
     * 获取京东二级地址 根据省份id获取城市信息
     * @param       Integer     id      省份id
     * @return mixed
     */
    public function getCitysAddress($postData) {
        $method = "biz.address.citysByProvinceId.query";

        // 业务参数可传键
        $paramKeys = array("id");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 获取京东三级地址 根据城市获取区县信息
     * @param       Integer     id      市id
     * @return mixed
     */
    public function getCountysAddress($postData) {
        $method = "biz.address.countysByCityId.query";

        // 业务参数可传键
        $paramKeys = array("id");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 获取京东四级地址 根据区县获取乡镇信息
     * @param       Integer     id      县id
     * @return mixed
     */
    public function getTownsAddress($postData) {
        $method = "biz.address.townsByCountyId.query";

        // 业务参数可传键
        $paramKeys = array("id");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 批量获取库存接口（建议订单详情页、下单使用）
     * @param       Array       skuNums         商品和数量  [{“skuId”: 569172,”num”:101}]  skuId 商品ID  num 商品数量
     * @param       string      area            格式：1_0_0_0 (分别代表1、2、3、4级地址，务必按照格式要求进行返回，如部分地区如北京、上海等地不存在4级地址，4级地址字段返回0)
     * @return mixed
     */
    public function getProductStockForDetailOrBuy($postData) {
        $method = "biz.stock.fororder.batget";

        // 业务参数可传键
        $paramKeys = array("skuNums", "area");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

    /**
     * 批量获取库存接口(建议商品列表页使用))
     * @param       sku                     商品编号 批量以逗号分隔 (最高支持100个商品)
     * @param       String      area        格式：1_0_0 (分别代表1、2、3级地址)
     * @return mixed
     */
    public function getProductStockForLists($postData) {
        $method = "biz.stock.forList.batget";

        // 业务参数可传键
        $paramKeys = array("sku", "area");

        // 拼接业务参数
        $paramArray = $this->createBusinessParameter($paramKeys, $postData);
        $resultArray = $this->requestApi($method, $paramArray);
        return $resultArray;
    }

}