import java.util.ArrayList;

public class ALQueue<T> implements Queue<T> {
	
    private ArrayList<T> _queue;
	
    // default constructor
    public ALQueue() { 
		_queue = new ArrayList<T>();
	}
	
    // means of adding an item to collection 
    public void enqueue( T x ) {
		_queue.add(0, x);
	}//O(1)
	
	
    // means of removing an item from collection 
    public T dequeue() {
		return _queue.remove(_queue.size()-1);
	}//O(1)
	
	
    // means of "peeking" at the front item
    public T peekFront() {
		return _queue.get(_queue.size()-1);
	}//O(1)
	
	
    // means of checking to see if collection is empty
    public boolean isEmpty() {
		return _queue.size() == 0;
	}//O(1)
	
	
    public String toString() {
		return _queue.toString();
	}

    public int size() { return _queue.size(); }
    
    public T get( int i ) { return _queue.get(i-1); }
	
	
}//end class ALQueue