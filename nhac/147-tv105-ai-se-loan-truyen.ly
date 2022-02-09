% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ai Sẽ Loan Truyền" }
  composer = "Tv. 105"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f8. g16 d8 c ~ |
  c a' a f16 (g) |
  c2 |
  c8. bf16 d8 c ~ |
  c a g16 (c) e,8 |
  f2 |
  g8. e16 d8 c ~ |
  c bf' bf a |
  g2 |
  g8. g16 g8 bf ~ |
  bf c e, g |
  f2 \bar "||" \break
  
  f8. e16 a (bf)
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tiny
      \once \override NoteColumn.force-hshift = #-2
      a16
      \once \override NoteColumn.force-hshift = #-2
      a
    }
  >>
  \oneVoice
  g4. e8 |
  f f4
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tiny
      \once \override NoteColumn.force-hshift = #-1.5
      \parenthesize
      a'
    }
  >>
  \oneVoice
  c,2 |
  f8. c16 a' (bf)
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tiny
      \once \override NoteColumn.force-hshift = #-2
      a16
      \once \override NoteColumn.force-hshift = #-2
      a
    }
  >>
  \oneVoice
  g4. g8 |
  bf bf4 c8 |
  f,2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8. g16 d8 c ~ |
  c f f [d] |
  e2 |
  a8. g16 bf8 a ~ |
  a f c [cs] |
  d2 |
  bf8. bf16 b!8 c ~ |
  c d g f |
  e2 |
  e8. e16 e8 d ~ |
  d d c bf |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ai sẽ loan truyền huân công của Chúa
  Ai sẽ xướng lên câu tán tụng Ngài.
  Phúc thay ai hằng giữ đức công minh,
  và hằng thực thi những điều ngay lành.
  <<
    {
      \set stanza = "1."
      Ôi lòng Chúa khoan nhân
      nào ta mau cảm tạ
      Ân tình Chúa bao la
      ngàn năm luôn vững bền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Xin Ngài nhớ đến con
	    vì yêu thương dân Ngài
	    Xin ngự đến viếng thăm
	    và ban ơn cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin được thấy phúc ân
	    danh cho ai
	    \markup { \underline \italic "Chúa" }
	    chọn
	    Tâm hồn sẽ sướng vui,
	    niềm vui dân thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "4."
      Trong ngàn nỗi truân chuyên
      cùng kêu van lên Ngài
      Theo lượng cả yêu thương
      Ngài ra tay cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ôi lạy Chúa chúng con
	    nguyện xin qui tụ về
	    Cho đoàn chúng con đây
	    ngợi ca danh thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Như tiền bối trước kia
	    họ bao phen \markup { \italic \underline "lỗi" } phạm
	    Nhưng vì nhớ Thánh Danh,
	    Ngài ra tay cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "7."
      Theo lời Chúa phán ra
      cạn khô ngay \markup { \italic \underline "biển" } Hồng
      Đưa họ tiến bước qua
      tựa đi trong đất liền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Khi Ngài cứu thoát dân
	    khỏi bao tay quân thù
	    Tin lời Chúa đã ban
	    họ ca vang tán tụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Nhưng họ chóng lãng quên
	    kỳ công tay \markup { \italic \underline "Chúa" } làm
	    Buông lòng với đam mê,
	    họ kêu than trách Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "10."
      Đem vàng đúc con bê
      tại chân Hô -- rép nọ
      Xin phục bái kính tôn
      bò bê thay Chúa họ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "11."
	    Nên Ngài tính tru di
	    bọn dân ngoan \markup { \italic \underline "cố" } này
	    Nhưng nhờ có Mô -- sê,
	    Ngài nguôi cơn nghĩa nộ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "12."
	    Khinh miền đất tốt tươi,
	    chẳng tin như \markup { \italic \underline "Chúa" } dậy
	    Trong trại chúng kêu ca,
	    chẳng nghe theo tiếng Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "13."
      Đi phục bái Ba -- an,
      tiệc thây ma \markup { \italic \underline "lãnh" } phần
      Trêu giận Chúa khôn ngơi
      làm tai ương dẫy đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "14."
	    Bên dòng nước
	    \markup { \italic \underline "Mê - ri" } -- ba
	    họ trêu cơn giận Ngài
	    Do vậy khiến Mô -- sê
	    giận căm nên chuốc họa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "15."
	    Chung đụng với chư dân
	    và đua theo \markup { \italic \underline "chúng" } hoài
	    Nên họ đã sa chân
	    mà suy tôn ngẫu thần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "16."
      Đây họ giết con trai
      và luôn con \markup { \italic \underline "gái" } mình
      Dâng thần đất
      \markup { \italic \underline "Ca - na" } -- an
      làm hoen ô đất này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "17."
	    Trên đầu lũ dân riêng
	    Ngài mưa cơn \markup { \italic \underline "nghĩa" } nộ
	    Trao mặc để chư dân
	    mạnh tay uy hiếp họ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "18."
	    Bao lần Chúa cứu nguy,
	    họ khôi thôi \markup { \italic \underline "phản" } nghịch
	    Nhưng vì Thánh ước xưa,
	    Ngài yêu thương đoái lại.
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
  page-count = #2
}

TongNhip = {
  \key f \major \time 2/4
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
