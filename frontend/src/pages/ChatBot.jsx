import React, { useState } from 'react';
import axios from 'axios';

const Chatbot = () => {
  const [question, setQuestion] = useState('');
  const [response, setResponse] = useState('');
  const [loading, setLoading] = useState(false);

  const handleInputChange = (event) => {
    setQuestion(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setLoading(true);
    try {
      const encodedName = encodeURIComponent(question);
    // Send the GET request
      const res = await axios.get(`http://127.0.0.1:8080/chat/${question}`);
      setResponse(res.data.response);
    } catch (error) {
      console.error('Error fetching the response:', error);
      setResponse('Sorry, there was an error processing your request.');
    }
    setLoading(false);
  };

  return (
    <div style={{ maxWidth: '600px', margin: '0 auto', padding: '1em' }}>
      <h1>Psychologist ChatBot</h1>
      <form onSubmit={handleSubmit}>
        <textarea
          value={question}
          onChange={handleInputChange}
          placeholder="Ask your question..."
          style={{ width: '100%', padding: '0.5em', fontSize: '1em', height: '200px' }}
          required
        />
        <button type="submit" style={{ marginTop: '1em', padding: '0.5em 1em' }}>
          {loading ? 'Loading...' : 'Submit'}
        </button>
      </form>
      {response && (
        <div style={{ marginTop: '2em', padding: '1em', border: '1px solid #ccc', borderRadius: '8px' }}>
          <strong>Response:</strong>
          <p>{response}</p>
        </div>
      )}
    </div>
  );
};

export default Chatbot;