
import org.omnetpp.queueing.Classifier;
import org.omnetpp.queueing.Delay;
import org.omnetpp.queueing.FileBasedSource;
import org.omnetpp.queueing.PassiveQueue;
import org.omnetpp.queueing.Router;
import org.omnetpp.queueing.Server;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;

network PriorityControl
{
    submodules:
			vehicle0: FileBasedSource {
			}
			vehicle1: FileBasedSource {
			}
			vehicle10: FileBasedSource {
			}
			vehicle11: FileBasedSource {
			}
			vehicle12: FileBasedSource {
			}
			vehicle13: FileBasedSource {
			}
			vehicle14: FileBasedSource {
			}
			vehicle15: FileBasedSource {
			}
			vehicle16: FileBasedSource {
			}
			vehicle17: FileBasedSource {
			}
			vehicle18: FileBasedSource {
			}
			vehicle19: FileBasedSource {
			}
			vehicle2: FileBasedSource {
			}
			vehicle20: FileBasedSource {
			}
			vehicle21: FileBasedSource {
			}
			vehicle22: FileBasedSource {
			}
			vehicle23: FileBasedSource {
			}
			vehicle24: FileBasedSource {
			}
			vehicle25: FileBasedSource {
			}
			vehicle26: FileBasedSource {
			}
			vehicle27: FileBasedSource {
			}
			vehicle28: FileBasedSource {
			}
			vehicle29: FileBasedSource {
			}
			vehicle3: FileBasedSource {
			}
			vehicle30: FileBasedSource {
			}
			vehicle31: FileBasedSource {
			}
			vehicle32: FileBasedSource {
			}
			vehicle33: FileBasedSource {
			}
			vehicle34: FileBasedSource {
			}
			vehicle35: FileBasedSource {
			}
			vehicle36: FileBasedSource {
			}
			vehicle37: FileBasedSource {
			}
			vehicle38: FileBasedSource {
			}
			vehicle39: FileBasedSource {
			}
			vehicle4: FileBasedSource {
			}
			vehicle40: FileBasedSource {
			}
			vehicle41: FileBasedSource {
			}
			vehicle42: FileBasedSource {
			}
			vehicle43: FileBasedSource {
			}
			vehicle44: FileBasedSource {
			}
			vehicle45: FileBasedSource {
			}
			vehicle46: FileBasedSource {
			}
			vehicle47: FileBasedSource {
			}
			vehicle48: FileBasedSource {
			}
			vehicle49: FileBasedSource {
			}
			vehicle5: FileBasedSource {
			}
			vehicle50: FileBasedSource {
			}
			vehicle51: FileBasedSource {
			}
			vehicle52: FileBasedSource {
			}
			vehicle53: FileBasedSource {
			}
			vehicle54: FileBasedSource {
			}
			vehicle55: FileBasedSource {
			}
			vehicle56: FileBasedSource {
			}
			vehicle57: FileBasedSource {
			}
			vehicle58: FileBasedSource {
			}
			vehicle59: FileBasedSource {
			}
			vehicle6: FileBasedSource {
			}
			vehicle60: FileBasedSource {
			}
			vehicle61: FileBasedSource {
			}
			vehicle62: FileBasedSource {
			}
			vehicle63: FileBasedSource {
			}
			vehicle64: FileBasedSource {
			}
			vehicle65: FileBasedSource {
			}
			vehicle66: FileBasedSource {
			}
			vehicle67: FileBasedSource {
			}
			vehicle68: FileBasedSource {
			}
			vehicle69: FileBasedSource {
			}
			vehicle7: FileBasedSource {
			}
			vehicle70: FileBasedSource {
			}
			vehicle71: FileBasedSource {
			}
			vehicle72: FileBasedSource {
			}
			vehicle73: FileBasedSource {
			}
			vehicle74: FileBasedSource {
			}
			vehicle75: FileBasedSource {
			}
			vehicle76: FileBasedSource {
			}
			vehicle77: FileBasedSource {
			}
			vehicle78: FileBasedSource {
			}
			vehicle79: FileBasedSource {
			}
			vehicle8: FileBasedSource {
			}
			vehicle80: FileBasedSource {
			}
			vehicle81: FileBasedSource {
			}
			vehicle82: FileBasedSource {
			}
			vehicle83: FileBasedSource {
			}
			vehicle84: FileBasedSource {
			}
			vehicle85: FileBasedSource {
			}
			vehicle86: FileBasedSource {
			}
			vehicle87: FileBasedSource {
			}
			vehicle88: FileBasedSource {
			}
			vehicle89: FileBasedSource {
			}
			vehicle9: FileBasedSource {
			}
			vehicle90: FileBasedSource {
			}
			vehicle91: FileBasedSource {
			}
			vehicle92: FileBasedSource {
			}
			vehicle93: FileBasedSource {
			}
			vehicle94: FileBasedSource {
			}
			vehicle95: FileBasedSource {
			}
			vehicle96: FileBasedSource {
			}
			vehicle97: FileBasedSource {
			}
			vehicle98: FileBasedSource {
			}
			vehicle99: FileBasedSource {
			}
			CPU1: Server {
			}
			CPU2: Server {
			}
			CPU3: Server {
			}
			CPU4: Server {
			}
			CPU5: Server {
			}
			CPU6: Server {
			}
			CPU7: Server {
			}
			CPU8: Server {
			}
			CPU9: Server {
			}
			CPU10: Server {
			}
			CPU11: Server {
			}
			CPU12: Server {
			}
			CPU13: Server {
			}
			CPU14: Server {
			}
			CPU15: Server {
			}
			CPU16: Server {
			}
			CPU17: Server {
			}
			CPU18: Server {
			}
			CPU19: Server {
			}
			CPU20: Server {
			}
			CPU21: Server {
			}
			CPU22: Server {
			}
			CPU23: Server {
			}
			CPU24: Server {
			}
			CPU25: Server {
			}
			CPU26: Server {
			}
			CPU27: Server {
			}
			CPU28: Server {
			}
			CPU29: Server {
			}
			CPU30: Server {
			}
			CPU31: Server {
			}
			CPU32: Server {
			}
			CPU33: Server {
			}
			CPU34: Server {
			}
			CPU35: Server {
			}
			CPU36: Server {
			}
			High_Priority_Queue1: PassiveQueue {
			}
			High_Priority_Queue2: PassiveQueue {
			}
			High_Priority_Queue3: PassiveQueue {
			}
			High_Priority_Queue4: PassiveQueue {
			}
			High_Priority_Queue5: PassiveQueue {
			}
			High_Priority_Queue6: PassiveQueue {
			}
			High_Priority_Queue7: PassiveQueue {
			}
			High_Priority_Queue8: PassiveQueue {
			}
			High_Priority_Queue9: PassiveQueue {
			}
			Low_Priority_Queue1: PassiveQueue {
			}
			Low_Priority_Queue2: PassiveQueue {
			}
			Low_Priority_Queue3: PassiveQueue {
			}
			Low_Priority_Queue4: PassiveQueue {
			}
			Low_Priority_Queue5: PassiveQueue {
			}
			Low_Priority_Queue6: PassiveQueue {
			}
			Low_Priority_Queue7: PassiveQueue {
			}
			Low_Priority_Queue8: PassiveQueue {
			}
			Low_Priority_Queue9: PassiveQueue {
			}
			Served1: Sink {
			}
			Served2: Sink {
			}
			Served3: Sink {
			}
			Served4: Sink {
			}
			Served5: Sink {
			}
			Served6: Sink {
			}
			Served7: Sink {
			}
			Served8: Sink {
			}
			Served9: Sink {
			}
			Served10: Sink {
			}
			Served11: Sink {
			}
			Served12: Sink {
			}
			Served13: Sink {
			}
			Served14: Sink {
			}
			Served15: Sink {
			}
			Served16: Sink {
			}
			Served17: Sink {
			}
			Served18: Sink {
			}
			Served19: Sink {
			}
			Served20: Sink {
			}
			Served21: Sink {
			}
			Served22: Sink {
			}
			Served23: Sink {
			}
			Served24: Sink {
			}
			Served25: Sink {
			}
			Served26: Sink {
			}
			Served27: Sink {
			}
			Served28: Sink {
			}
			Served29: Sink {
			}
			Served30: Sink {
			}
			Served31: Sink {
			}
			Served32: Sink {
			}
			Served33: Sink {
			}
			Served34: Sink {
			}
			Served35: Sink {
			}
			Served36: Sink {
			}
			hangingUp1: Sink {
			}
			hangingUp2: Sink {
			}
			hangingUp3: Sink {
			}
			hangingUp4: Sink {
			}
			hangingUp5: Sink {
			}
			hangingUp6: Sink {
			}
			hangingUp7: Sink {
			}
			hangingUp8: Sink {
			}
			hangingUp9: Sink {
			}
			Classifier1: Classifier {
			}
			Classifier2: Classifier {
			}
			Classifier3: Classifier {
			}
			Classifier4: Classifier {
			}
			Classifier5: Classifier {
			}
			Classifier6: Classifier {
			}
			Classifier7: Classifier {
			}
			Classifier8: Classifier {
			}
			Classifier9: Classifier {
			}
			router: Router {
			}
		connections:			Classifier1.out++ --> High_Priority_Queue1.in++;
			Classifier1.out++ --> Low_Priority_Queue1.in++;
			Classifier1.rest --> hangingUp1.in++;
			High_Priority_Queue1.out++ --> CPU1.in++;
			Low_Priority_Queue1.out++ --> CPU1.in++;
			CPU1.out --> Served1.in++;
			High_Priority_Queue1.out++ --> CPU2.in++;
			Low_Priority_Queue1.out++ --> CPU2.in++;
			CPU2.out --> Served2.in++;
			High_Priority_Queue1.out++ --> CPU3.in++;
			Low_Priority_Queue1.out++ --> CPU3.in++;
			CPU3.out --> Served3.in++;
			High_Priority_Queue1.out++ --> CPU4.in++;
			Low_Priority_Queue1.out++ --> CPU4.in++;
			CPU4.out --> Served4.in++;
			router.out ++ --> Classifier1.in++;
			Classifier2.out++ --> High_Priority_Queue2.in++;
			Classifier2.out++ --> Low_Priority_Queue2.in++;
			Classifier2.rest --> hangingUp2.in++;
			High_Priority_Queue2.out++ --> CPU5.in++;
			Low_Priority_Queue2.out++ --> CPU5.in++;
			CPU5.out --> Served5.in++;
			High_Priority_Queue2.out++ --> CPU6.in++;
			Low_Priority_Queue2.out++ --> CPU6.in++;
			CPU6.out --> Served6.in++;
			High_Priority_Queue2.out++ --> CPU7.in++;
			Low_Priority_Queue2.out++ --> CPU7.in++;
			CPU7.out --> Served7.in++;
			High_Priority_Queue2.out++ --> CPU8.in++;
			Low_Priority_Queue2.out++ --> CPU8.in++;
			CPU8.out --> Served8.in++;
			router.out ++ --> Classifier2.in++;
			Classifier3.out++ --> High_Priority_Queue3.in++;
			Classifier3.out++ --> Low_Priority_Queue3.in++;
			Classifier3.rest --> hangingUp3.in++;
			High_Priority_Queue3.out++ --> CPU9.in++;
			Low_Priority_Queue3.out++ --> CPU9.in++;
			CPU9.out --> Served9.in++;
			High_Priority_Queue3.out++ --> CPU10.in++;
			Low_Priority_Queue3.out++ --> CPU10.in++;
			CPU10.out --> Served10.in++;
			High_Priority_Queue3.out++ --> CPU11.in++;
			Low_Priority_Queue3.out++ --> CPU11.in++;
			CPU11.out --> Served11.in++;
			High_Priority_Queue3.out++ --> CPU12.in++;
			Low_Priority_Queue3.out++ --> CPU12.in++;
			CPU12.out --> Served12.in++;
			router.out ++ --> Classifier3.in++;
			Classifier4.out++ --> High_Priority_Queue4.in++;
			Classifier4.out++ --> Low_Priority_Queue4.in++;
			Classifier4.rest --> hangingUp4.in++;
			High_Priority_Queue4.out++ --> CPU13.in++;
			Low_Priority_Queue4.out++ --> CPU13.in++;
			CPU13.out --> Served13.in++;
			High_Priority_Queue4.out++ --> CPU14.in++;
			Low_Priority_Queue4.out++ --> CPU14.in++;
			CPU14.out --> Served14.in++;
			High_Priority_Queue4.out++ --> CPU15.in++;
			Low_Priority_Queue4.out++ --> CPU15.in++;
			CPU15.out --> Served15.in++;
			High_Priority_Queue4.out++ --> CPU16.in++;
			Low_Priority_Queue4.out++ --> CPU16.in++;
			CPU16.out --> Served16.in++;
			router.out ++ --> Classifier4.in++;
			Classifier5.out++ --> High_Priority_Queue5.in++;
			Classifier5.out++ --> Low_Priority_Queue5.in++;
			Classifier5.rest --> hangingUp5.in++;
			High_Priority_Queue5.out++ --> CPU17.in++;
			Low_Priority_Queue5.out++ --> CPU17.in++;
			CPU17.out --> Served17.in++;
			High_Priority_Queue5.out++ --> CPU18.in++;
			Low_Priority_Queue5.out++ --> CPU18.in++;
			CPU18.out --> Served18.in++;
			High_Priority_Queue5.out++ --> CPU19.in++;
			Low_Priority_Queue5.out++ --> CPU19.in++;
			CPU19.out --> Served19.in++;
			High_Priority_Queue5.out++ --> CPU20.in++;
			Low_Priority_Queue5.out++ --> CPU20.in++;
			CPU20.out --> Served20.in++;
			router.out ++ --> Classifier5.in++;
			Classifier6.out++ --> High_Priority_Queue6.in++;
			Classifier6.out++ --> Low_Priority_Queue6.in++;
			Classifier6.rest --> hangingUp6.in++;
			High_Priority_Queue6.out++ --> CPU21.in++;
			Low_Priority_Queue6.out++ --> CPU21.in++;
			CPU21.out --> Served21.in++;
			High_Priority_Queue6.out++ --> CPU22.in++;
			Low_Priority_Queue6.out++ --> CPU22.in++;
			CPU22.out --> Served22.in++;
			High_Priority_Queue6.out++ --> CPU23.in++;
			Low_Priority_Queue6.out++ --> CPU23.in++;
			CPU23.out --> Served23.in++;
			High_Priority_Queue6.out++ --> CPU24.in++;
			Low_Priority_Queue6.out++ --> CPU24.in++;
			CPU24.out --> Served24.in++;
			router.out ++ --> Classifier6.in++;
			Classifier7.out++ --> High_Priority_Queue7.in++;
			Classifier7.out++ --> Low_Priority_Queue7.in++;
			Classifier7.rest --> hangingUp7.in++;
			High_Priority_Queue7.out++ --> CPU25.in++;
			Low_Priority_Queue7.out++ --> CPU25.in++;
			CPU25.out --> Served25.in++;
			High_Priority_Queue7.out++ --> CPU26.in++;
			Low_Priority_Queue7.out++ --> CPU26.in++;
			CPU26.out --> Served26.in++;
			High_Priority_Queue7.out++ --> CPU27.in++;
			Low_Priority_Queue7.out++ --> CPU27.in++;
			CPU27.out --> Served27.in++;
			High_Priority_Queue7.out++ --> CPU28.in++;
			Low_Priority_Queue7.out++ --> CPU28.in++;
			CPU28.out --> Served28.in++;
			router.out ++ --> Classifier7.in++;
			Classifier8.out++ --> High_Priority_Queue8.in++;
			Classifier8.out++ --> Low_Priority_Queue8.in++;
			Classifier8.rest --> hangingUp8.in++;
			High_Priority_Queue8.out++ --> CPU29.in++;
			Low_Priority_Queue8.out++ --> CPU29.in++;
			CPU29.out --> Served29.in++;
			High_Priority_Queue8.out++ --> CPU30.in++;
			Low_Priority_Queue8.out++ --> CPU30.in++;
			CPU30.out --> Served30.in++;
			High_Priority_Queue8.out++ --> CPU31.in++;
			Low_Priority_Queue8.out++ --> CPU31.in++;
			CPU31.out --> Served31.in++;
			High_Priority_Queue8.out++ --> CPU32.in++;
			Low_Priority_Queue8.out++ --> CPU32.in++;
			CPU32.out --> Served32.in++;
			router.out ++ --> Classifier8.in++;
			Classifier9.out++ --> High_Priority_Queue9.in++;
			Classifier9.out++ --> Low_Priority_Queue9.in++;
			Classifier9.rest --> hangingUp9.in++;
			High_Priority_Queue9.out++ --> CPU33.in++;
			Low_Priority_Queue9.out++ --> CPU33.in++;
			CPU33.out --> Served33.in++;
			High_Priority_Queue9.out++ --> CPU34.in++;
			Low_Priority_Queue9.out++ --> CPU34.in++;
			CPU34.out --> Served34.in++;
			High_Priority_Queue9.out++ --> CPU35.in++;
			Low_Priority_Queue9.out++ --> CPU35.in++;
			CPU35.out --> Served35.in++;
			High_Priority_Queue9.out++ --> CPU36.in++;
			Low_Priority_Queue9.out++ --> CPU36.in++;
			CPU36.out --> Served36.in++;
			router.out ++ --> Classifier9.in++;
			vehicle0.out --> router.in++;
			vehicle1.out --> router.in++;
			vehicle10.out --> router.in++;
			vehicle11.out --> router.in++;
			vehicle12.out --> router.in++;
			vehicle13.out --> router.in++;
			vehicle14.out --> router.in++;
			vehicle15.out --> router.in++;
			vehicle16.out --> router.in++;
			vehicle17.out --> router.in++;
			vehicle18.out --> router.in++;
			vehicle19.out --> router.in++;
			vehicle2.out --> router.in++;
			vehicle20.out --> router.in++;
			vehicle21.out --> router.in++;
			vehicle22.out --> router.in++;
			vehicle23.out --> router.in++;
			vehicle24.out --> router.in++;
			vehicle25.out --> router.in++;
			vehicle26.out --> router.in++;
			vehicle27.out --> router.in++;
			vehicle28.out --> router.in++;
			vehicle29.out --> router.in++;
			vehicle3.out --> router.in++;
			vehicle30.out --> router.in++;
			vehicle31.out --> router.in++;
			vehicle32.out --> router.in++;
			vehicle33.out --> router.in++;
			vehicle34.out --> router.in++;
			vehicle35.out --> router.in++;
			vehicle36.out --> router.in++;
			vehicle37.out --> router.in++;
			vehicle38.out --> router.in++;
			vehicle39.out --> router.in++;
			vehicle4.out --> router.in++;
			vehicle40.out --> router.in++;
			vehicle41.out --> router.in++;
			vehicle42.out --> router.in++;
			vehicle43.out --> router.in++;
			vehicle44.out --> router.in++;
			vehicle45.out --> router.in++;
			vehicle46.out --> router.in++;
			vehicle47.out --> router.in++;
			vehicle48.out --> router.in++;
			vehicle49.out --> router.in++;
			vehicle5.out --> router.in++;
			vehicle50.out --> router.in++;
			vehicle51.out --> router.in++;
			vehicle52.out --> router.in++;
			vehicle53.out --> router.in++;
			vehicle54.out --> router.in++;
			vehicle55.out --> router.in++;
			vehicle56.out --> router.in++;
			vehicle57.out --> router.in++;
			vehicle58.out --> router.in++;
			vehicle59.out --> router.in++;
			vehicle6.out --> router.in++;
			vehicle60.out --> router.in++;
			vehicle61.out --> router.in++;
			vehicle62.out --> router.in++;
			vehicle63.out --> router.in++;
			vehicle64.out --> router.in++;
			vehicle65.out --> router.in++;
			vehicle66.out --> router.in++;
			vehicle67.out --> router.in++;
			vehicle68.out --> router.in++;
			vehicle69.out --> router.in++;
			vehicle7.out --> router.in++;
			vehicle70.out --> router.in++;
			vehicle71.out --> router.in++;
			vehicle72.out --> router.in++;
			vehicle73.out --> router.in++;
			vehicle74.out --> router.in++;
			vehicle75.out --> router.in++;
			vehicle76.out --> router.in++;
			vehicle77.out --> router.in++;
			vehicle78.out --> router.in++;
			vehicle79.out --> router.in++;
			vehicle8.out --> router.in++;
			vehicle80.out --> router.in++;
			vehicle81.out --> router.in++;
			vehicle82.out --> router.in++;
			vehicle83.out --> router.in++;
			vehicle84.out --> router.in++;
			vehicle85.out --> router.in++;
			vehicle86.out --> router.in++;
			vehicle87.out --> router.in++;
			vehicle88.out --> router.in++;
			vehicle89.out --> router.in++;
			vehicle9.out --> router.in++;
			vehicle90.out --> router.in++;
			vehicle91.out --> router.in++;
			vehicle92.out --> router.in++;
			vehicle93.out --> router.in++;
			vehicle94.out --> router.in++;
			vehicle95.out --> router.in++;
			vehicle96.out --> router.in++;
			vehicle97.out --> router.in++;
			vehicle98.out --> router.in++;
			vehicle99.out --> router.in++;

}
