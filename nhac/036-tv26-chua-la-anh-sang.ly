% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Là Ánh Sáng" }
  composer = "Tv. 26"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  e4 c8 f |
  f4. d8 |
  a' a fs4 |
  g2 |
  r8 e d d |
  e2 |
  e4 c8 c |
  f4. e8 |
  d d a'4 |
  g2 |
  r8 c b b |
  c2 \bar "||" \break
  
  e,8 f d d |
  c8. c16 a'8 f |
  g4. e8 |
  e8. a16 a8 a |
  d,4 r8 d |
  c c f g |
  a8. f16 c'8 c |
  b4 r8 g |
  a8. a16 f8 d |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e4 c8 f |
  f4. d8 |
  a' a fs4 |
  g2 |
  r8 c, b b |
  c2 |
  e4 c8 c |
  f4. e8 |
  d d a'4 |
  g2 |
  r8 e d d |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúa là ánh sáng,
  là Đấng cứu độ tôi,
  Tôi sợ gì ai?
  Chúa là thành lũy bảo vệ mạng sống tôi,
  Tôi sợ gì ai?
  <<
    {
      \set stanza = "1."
      Khi ác nhân xông vào định xé thịt tôi,
      nào ngờ chính chúng té nhào.
      Nên dù địch quân gây chiến dồn tới xiết vây,
      Tôi vẫn vững tâm tin cậy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tôi ước mong một điều và khấn nguyện luôn:
	    ở đền thánh Chúa suốt đời,
	    Đêm ngày được cung nghiêm Chúa rạng rỡ ánh quang,
	    Trông ngắm thánh điện huy hoàng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Trong lúc tôi lâm nạn
	    Ngài vẫn chở che tại đến thánh Chúa sớm chiều,
	    An toàn đặt tôi trên đá,
	    Người khiến vững tâm,
	    Kiêu hãnh ngó lại quân thù.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con sẽ dâng lên Ngài của lễ tạ ơn,
	    Họa đàn cất tiếng hát mừng.
	    Xin Ngài để tai nghe thấu
	    từng tiếng khấn xin,
	    Mau mắn đoái thương nhận lời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con vẫn luôn nhủ lòng:
	    tìm kiếm Ngài luôn,
	    nguyện Ngài chớ nỡ lánh mặt.
	    Xin đừng đành tâm xua rẫy đầy tớ Chúa đây,
	    Ôi Đấng Cứu Độ con này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Cho dẫu khi cha mẹ đành chối từ con,
	    thì còn có Chúa đón nhận.
	    Xin Ngài dạy con cho biết đường lối thẳng ngay,
	    Đây đó lắm kẻ mưu hại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Xin chớ trao thân này vào lũ địch quân,
	    hầm hầm sát khí ám hại.
	    Con một lòng tin sẽ thấy hồng phúc Chúa
	    ban Trong đất những kẻ sinh tồn.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
