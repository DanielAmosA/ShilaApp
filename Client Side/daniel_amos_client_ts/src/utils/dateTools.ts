  // A generic function for handling date fields.

interface DateField {
    date: Date | string;
  }
  
  export const formatDateTime = <T extends DateField>(item?: T): string => {
    try {
      if (!item?.date) return 'אין תאריך';
      
      const date = new Date(item.date);
      
      // Format the date  
      const dateStr = date.toLocaleDateString('he-IL', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
      });
      
      // Format the time  
      const timeStr = date.toLocaleTimeString('he-IL', {
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
      });
      
      // Show Date | Time 
      return `${timeStr} ♛ ${dateStr} `;
    } catch (error) {
      console.error('Error formatting date:', error);
      return 'תאריך לא תקין';
    }
  };