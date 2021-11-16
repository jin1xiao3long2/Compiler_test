class A
    var root = ""
    var nodes = new array
    function to_string()
        var str = "root: " + root
        foreach node in nodes do str += (" node: " + node.root)
        return str
    end
end

function show_trees(node, depth)
    foreach i in range(depth) do system.out.print("\t")
    system.out.println(node.root)
    foreach son in node.nodes do show_trees(son, depth + 1) 
end

function compress_tree(node)
    system.out.print(node)
    system.out.println(" " + to_string(node.nodes.size))
    if node.nodes.size == 0
        return 
    end
    for iter = node.nodes.begin, iter != node.nodes.end, iter.next()
        compress_tree(iter.data)
        if iter.data.nodes.size == 1 && iter.data.nodes[0].root == "3"
            iter = node.nodes.erase(iter)
        end
    end

    return node
end

function main()

    var node0 = new A
    node0.root = "0"
    var node1 = new A
    node1.root = "1"
    var node2 = new A
    node2.root = "2"
    var node3 = new A
    node3.root = "3"
    var node4 = new A
    node4.root = "4"
    var node5 = new A
    node5.root = "5"
    var node6 = new A
    node6.root = "6"
    var node7 = new A
    node7.root = "7"
    var node8 = new A
    node8.root = "8"

    node6.nodes.push_back(node7)
    node6.nodes.push_back(node8)
    node4.nodes.push_back(node5)
    node4.nodes.push_back(node6)
    node2.nodes.push_back(node3)
    node1.nodes.push_back(node2)
    node1.nodes.push_back(node4)
    node0.nodes.push_back(node1)

    show_trees(node0, 0)

    compress_tree(node0)
    system.out.println("123")
    show_trees(node0, 0)
end


main()
