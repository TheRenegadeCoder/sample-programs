//Minimum Spanning Tree

function prim(graph){

	nodes=graph.getAllNodes();
	this.error=false;
	this.Vnode=[];
	this.Vedge=[];
	this.Vnode.push(nodes[0]);

	this.pq=new MinPQ();
	
	this.InsertEdgeIntoPQ(nodes[0],this.pq)
	
	while(this.Vnode.length!=nodes.length){

		if(this.pq.size()==0){ 
			this.error=true;
			return ;
		}

		while(this.pq.size()!=0){

			minEdge=this.pq.pop();
			if(this.Vnode.indexOf(minEdge[1])==-1){

				this.Vedge.push(minEdge);
				this.Vnode.push(minEdge[1]);
				this.InsertEdgeIntoPQ(minEdge[1],this.pq);
				break;
			}

		}
	}
	return;
}

prim.prototype.InsertEdgeIntoPQ = function(node,pq) {
	adjList=node.adjList;
	wights=node.weight;
	for (var i = 0; i < adjList.length; i++) {
		temp=[];
		temp.push(node);
		temp.push(adjList[i]);
		pq.push(temp,wights[i]);		
	}
}
//By - Nikhil Gupta
//GitHub - nikkkhil067
