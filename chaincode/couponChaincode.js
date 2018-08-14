const shim = require('fabric-shim');
const util = require('util');

let Chaincode = class {
    async Init(stub) {
        let ret = stub.getFunctionAndParameters();
        console.info('====================Instantiated Coupon Chaincode==============');
        console.info(ret);
        return shim.success();
    }

    async Invoke(stub) {
        console.info('Transaction ID : ' + stub.getTxID());
        console.info(util.format('Args: %j', stub.getArgs()));

        let ret = stub.getFunctionAndParameters();
        console.info('=================== Invoke =================================');
        console.info(ret);

        let method = this[ret.fcn];
        if (!method) {
            console.log('[Coupon] no function of name : ' + ret.fcn + ' found');
            throw new Error('Received unknown function ' + ret.fcn + ' invocation');
        }
        try {
            let payload = await method(stub, ret.params, this);
            return shim.success(payload);
        } catch (err) {
            console.log(err);
            return shim.error(err);
        }
    }
    // ============================================
    // createCoupon - create coupon
    // params : couponId, couponNm, startDtm, endDtm, couponGrpId
    // =========================================== 
    async createCoupon(stub, params) {
        if ( params.length != 5) {
            throw new Error('[createCoupon] Incorrect number of arguments. Expection 5');
        }
        let couponId = params[0];
        let couponNm = params[1];
        let startDtm = params[2];
        let endDtm = params[3];
        let usedPeer = "";
        let useDtm = "";
        let couponGrpId = params[4];

        // ===== 1. check if coupon already exists ====

        // ===== 2. create coupon object ====
        let coupon = {};
        coupon.couponId = couponId;
        coupon.couponNm = couponNm;
        coupon.startDtm = startDtm;
        coupon.endDtm = endDtm;
        coupon.usedPeer = usedPeer;
        coupon.useDtm = useDtm;
        coupon.couponGrpId = couponGrpId;

        // ===== 3. save coupon to state ====
        await stub.putState(couponId, Buffer.from(JSON.stringify(coupon)));
        let couponIndexKey = await stub.createCompositeKey('couponIdx', [coupon.couponId, coupon.couponGrpId]);
        console.info('createCouponIdx');
        console.info(couponIndexKey);
        await stub.putState(couponIndexKey, Buffer.from('\u0000'));
        console.info('====== end create Coupon');
    }

    // ============================================
    // getCoupon - get a coupon info
    // params : couponId
    // =========================================== 
    async getCoupon(stub, params) {
        if (params.length != 1) {
            throw new Error('[getCoupon] Incorrect number of arguments. Expection 1');
        }
        let couponId = params[0];
        if ( !couponId) {
            throw new Error(' coupon id must not be empty');
        }
        
        console.info('====getCoupon couponId : ' + couponId);
        let couponInfoAsBytes = await stub.getState(couponId);

        if (!couponInfoAsBytes.toString()) {
            let jsonRes = {};
            jsonRes.Error = 'coupon does not exist: ' + couponId;
            throw new Error(JSON.stringify(jsonRes));
        }

        console.info('======== getCoupon======================');
        console.info(couponInfoAsBytes.toString());
        console.info('=============================');

        return couponInfoAsBytes;


    }
}