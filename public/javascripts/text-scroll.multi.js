//div文字多行滚动
// window.onload=function(){
//  var sc = new Scroll(document.getElementById("scroll"));
//  var sc = new Scroll(document.getElementById("scroll2"));
//}
//div多层文字展示
//<div id="a1">
//    <div id="a2" style="position:relative;">
//    1111111111111111111111<br/>
//    </div>
//    <div id="a3" style="position:relative;top:-100px;">
//    2222222222222222222222
//    </div>
//</div>
(function(ns){
    function Scroll(element){

        var content = document.createElement("div");
        var container = document.createElement("div");
        var _this =this;
        var cssText = "position: absolute; visibility:hidden; left:0; white-space:nowrap;";
        this.element = element;
        this.contentWidth = 0;
        this.stop = false;

        content.innerHTML = element.innerHTML;

        //获取元素真实宽度
        content.style.cssText = cssText;
        element.appendChild(content);
        this.contentWidth = content.offsetWidth;

        content.style.cssText= "float:left;";
        container.style.cssText = "width: " + (this.contentWidth*2) + "px; overflow:hidden";
        container.appendChild(content);
        container.appendChild(content.cloneNode(true));
        element.innerHTML = "";
        element.appendChild(container);

        container.onmouseover = function(e){
            clearInterval(_this.timer);

        };

        container.onmouseout = function(e){
            _this.timer = setInterval(function(){
                _this.run();
            },20);


        };
        _this.timer = setInterval(function(){
            _this.run();
        }, 20);
    }

    Scroll.prototype = {

        run: function(){

            var _this = this;
            var element = _this.element;

            elementelement.scrollLeft = element.scrollLeft + 1;

            if(element.scrollLeft >=  this.contentWidth ) {
                element.scrollLeft = 0;
            }
        }
    };
    ns.Scroll = Scroll;
}(window));